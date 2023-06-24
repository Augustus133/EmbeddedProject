#include <WiFi.h>
#include <NTPClient.h>
#include <WiFiClient.h>
#include "FirebaseESP32.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/uart.h"

#define WIFI_SSID "Ti mart 2.4"
#define WIFI_PASSWORD "Vulan@1995"

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");
#define FIREBASE_HOST "https://esp32-test-67f41-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "PcO9eHMMmRj2YObVnzQYzHzTh0SYAI9CaoFA71fQ"

//#define FIREBASE_HOST "https://esp32test-1a774-default-rtdb.firebaseio.com/"
//#define FIREBASE_AUTH "ANuWZQ1znHeOpOvIgBr8KEJsJ718IZGD6jBuCPi6"

FirebaseData firebaseData;
FirebaseJson json;

#define UART_TX GPIO_NUM_17
#define UART_RX GPIO_NUM_16

volatile uint16_t speed_t;
char speed_s[6];

int x = 0;
String pathSpeed = "data/speed";
String pathTime = "data/time";
String pathDate = "data/date";

void uart_config(void) {
  uart_config_t uart_config = {
    .baud_rate = 9600,
    .data_bits = UART_DATA_8_BITS,
    .parity = UART_PARITY_DISABLE,
    .stop_bits = UART_STOP_BITS_1,
    .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
  };
  uart_param_config(UART_NUM_1, &uart_config);
  uart_set_pin(UART_NUM_1, UART_TX, UART_RX, UART_PIN_NO_CHANGE, UART_PIN_NO_CHANGE);
  uart_driver_install(UART_NUM_1, 256, 0, 0, NULL, 0);
  printf("UART driver installed\n");
}

int uart_task() {
  int result = 0;
  int rx_length = uart_read_bytes(UART_NUM_1, rx_buffer, sizeof(rx_buffer), 20 / portTICK_RATE_MS);

  if (rx_length > 0) {
    // In giá trị của byte đầu tiên trong mảng rx_buffer
    // printf("Value of rx_buffer[0]: %d\n", rx_buffer[0]);

    // Chuyển đổi giá trị của byte đầu tiên trong mảng rx_buffer về dạng số nguyên
    char buffer_str[4];
    sprintf(buffer_str, "%d", rx_buffer[0]);
    result = atoi(buffer_str);
  }

  return result;
}

void handleConnectWifi() {
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print("_");
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
}

void handleConnectFireBase() {

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  if (!Firebase.beginStream(firebaseData, pathSpeed)) {
    Serial.println("REASON: " + firebaseData.errorReason());
    Serial.println();
  }
  else {
    Serial.println("Stream started successfully");
  }

  Serial.println();
}

void SendDataToFirebase( int speed) {
  timeClient.update();
  String dateNow = timeClient.getFormattedTime();
  time_t currentTime = timeClient.getEpochTime();
  struct tm * timeInfo;
  timeInfo = localtime(&currentTime);
  int currentDay = timeInfo->tm_mday;
  int currentMonth = timeInfo->tm_mon + 1;
  int currentYear = timeInfo->tm_year + 1900;
  String currentDate = String(currentYear) + "-" + String(currentMonth) + "-" + String(currentDay);
  Firebase.pushInt(firebaseData, pathSpeed, speed);
  Firebase.pushString(firebaseData, pathTime, dateNow);
  Firebase.pushString(firebaseData, pathDate, currentDate);
Serial.println("time: " + dateNow);
Serial.println("date: " + currentDate);

}

void handleSetTime() {
  timeClient.begin();
  timeClient.setTimeOffset(25200); // 7 * 60 * 60
  while (!timeClient.update()) {
    timeClient.forceUpdate();
  }
}

void setup() {
  uart_config();
  handleConnectWifi();
  handleSetTime();
  handleConnectFireBase();
  Serial.begin(115200);
}

void loop() {
  int speed = uart_task();
  if (speed != 0) {
    Serial.println(speed);
    SendDataToFirebase(speed);
  }
  vTaskDelay(10 / portTICK_RATE_MS);
}

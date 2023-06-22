`timescale 1ns/1ns

module top_tb #(
   parameter WIDTH_TIK   = 16,
   parameter WIDTH_MS    =  9,
   parameter WIDTH_SPEED = 14
)();

reg                    sys_clock           ;
reg                    reset_n       ;
reg                    sensor1       ;
reg                    sensor2       ;
reg                    sensor3       ;
reg     [1:0]          valid_Epass   ;
reg                    enable        ;
// wire [WIDTH_SPEED:0] done_speed      ;
// wire                   done       ;
wire                   barrier       ;
wire                   serial_data_out    ;

design_1_wrapper  DUT (
   .sys_clock  (sys_clock  ),
   .reset_n    (reset_n    ),
   .sensor1    (sensor1    ),
   .sensor2    (sensor2    ),
   .sensor3    (sensor3    ),
   .valid_Epass(valid_Epass),
   .enable     (enable     ),
   .clock     (clock       ),
   .barrier    (barrier    ),
   .serial_data_out       (serial_data_out       )
);

always #5 sys_clock = ~sys_clock;

initial begin
    reset_n =0;
    #500;
////   fork
////      // sensor 1
////      begin 
////         // Luot thu 1
////         sys_clock = 0;
////         reset_n = 0;
////         sensor1 =0;
////         enable = 0;
////         @(negedge sys_clock);
////         reset_n = 1;
////         #10000;
////         sensor1 = 1;
////         #144000000; // Thoi gian oto di qua 1 sensor
////         sensor1 = 0;

////         // Luot thu 2
////         #1200000000;
////         #1000000000;
////         sensor1 = 1;
////         #144000000; // Thoi gian oto di qua 1 sensor
////         sensor1 = 0;
////      end

////      // sensor 2
////      begin 
////         // Luot thu 1
////         sensor2 = 0;
////         valid_Epass = 2'b00;
////         @(negedge sys_clock);
////         #10000;
////         #(480000000-50000000); // Thoi gian oto di tu sensor 1 den sensor 2
////         sensor2 = 1;
////         #50000000;
////         valid_Epass = 2'b10;
////         #144000000; // Thoi gian oto di qua 1 sensor
////         sensor2 = 0;
////         valid_Epass = 2'b00;

////         // Luot thu 2
////         #(720000000-50000000);
////         #1000000000;
////         #240000000;  // Thoi gian oto di tu sensor 1 den sensor 2
////         sensor2 = 1;
////         #50000000;
////         valid_Epass = 2'b10;
////         #144000000; // Thoi gian oto di qua 1 sensor
////         sensor2 = 0;
////         valid_Epass = 2'b00;
////      end

////      // sensor 3
////      begin 
////         // Luot thu 1
////         sensor3 = 0;
////         #10000;
////         #1200000000; // Thoi gian oto di tu sensor 1 den sensor 3
////         sensor3 = 1;
////         #144000000; // Thoi gian oto di qua 1 sensor
////         sensor3 = 0;

////         // Luot thu 2
////         #1000000000;
////         #600000000; // Thoi gian oto di tu sensor 1 den sensor 3
////         sensor3 = 1;
////         #144000000; // Thoi gian oto di qua 1 sensor
////         sensor3 = 0;
////      end
////   join

//   // #(100 * 1000000); 
//   sys_clock = 0;
//   sensor1 = 0;
//   sensor2 = 0;
//   sensor3 = 0;
//   // reset_n = 0;
//   valid_Epass = 2'b00;
//   enable = 0;
//   @(negedge sys_clock);
//   reset_n = 1;
//   #1000000;
//   // #(100 * 1000000);
//   // sensor1 = 1;
//   // #(640*1000000);
//   // sensor2 = 1;
//   // #(1600*1000000 - 640*1000000);
//   // sensor1 = 1;

//   fork
//      begin 
//         //        Xe 1
//         // 22.5 km/h 
//         // 4m -> 4*3.6*1000/22.5 = 0.64s
//         // 6m -> 6/6.25 = 0.96s
//         sensor1 = 1;
//         repeat(640) #1000000;
//         sensor2 = 1;
//         repeat(960) #1000000;
//         sensor3 = 1;
//      end

//      begin 
//         //        Xe 1
//         // Dai 10m -> 1.6s
//         repeat(1600) #1000000;
//         sensor1 = 0;
//         repeat(640) #1000000;
//         sensor2 = 0;
//         repeat(960) #1000000;
//         sensor3 = 0;
//      end
//   join
   
//   #1000000;

   sys_clock = 0;
   sensor1 = 0;
   sensor2 = 0;
   sensor3 = 0;
   reset_n = 0;
   valid_Epass = 2'b00;
   enable = 0;
   @(negedge sys_clock);
   reset_n = 1;
   #100000;
   sensor1 = 1;
   #100000;
   sensor2 = 1;
   #100000;
   valid_Epass = 2'b01;
   #100000;
   enable = 1;

   #1000000;
   sensor3 = 1;
   #100000;
   sensor1 = 0;
   #10000000;
   sensor2 = 0;
   #100000;
   enable = 0;
   sensor3 = 0;
   valid_Epass = 2'b00;
   #1000000;

   sensor1=1;
   #6400000;
   sensor2=1;
   #800000;
   valid_Epass =2'b01;
   #800000;
   sensor1=0;
   #2000000;
   enable = 1;
   #4400000;
   sensor2=0;
   sensor1=1;
   #2000000;
   sensor3=1;
   valid_Epass=2'b00;
   #4400000;
   sensor2=1;
   #1600000;
   sensor1=0;
   valid_Epass=2'b10;
   #400000;
   sensor3=0;
   enable=0;
   #4000000;
   sensor2=0;
   #2000000;
   sensor3=1;
   #6400000;
   sensor3=0;
   
   #5000000;

   fork
      begin 
         //        Xe 1
         // 22.5 km/h 
         // 4m -> 4*3.6*1000/22.5 = 0.64s
         // 6m -> 6/6.25 = 0.96s
         sensor1 = 1;
         repeat(640) #1000000;
         sensor2 = 1;
         repeat(960) #1000000;
         sensor3 = 1;
      end

      begin 
         //        Xe 1
         // Dai 10m -> 1.6s
         repeat(1600) #1000000;
         sensor1 = 0;
         repeat(640) #1000000;
         sensor2 = 0;
         repeat(960) #1000000;
         sensor3 = 0;
      end
   join  
   $finish;
end
endmodule

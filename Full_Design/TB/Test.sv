

program testcase(input_interface.IP input_intf,output_interface.OP output_intf);

Environment env;
generator pkt;

initial
begin
$display(" ******************* Start of testcase ****************");
pkt = new();
env = new(input_intf,output_intf);
env.build();
env.run();
#1000;
end

final
$display(" ******************** End of testcase *****************");


endprogram 


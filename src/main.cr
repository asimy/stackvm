require "./stack-vm"

vm = StackVM.new
add : UInt32 = 0x40000001
sub : UInt32 = 0x40000002
mul : UInt32 = 0x40000003
div : UInt32 = 0x40000004
halt : UInt32 = 0x40000000
prog : Array(UInt32) = [ 3.to_u, 4.to_u, mul, 4.to_u, add, 128.to_u, div, 15.to_u, sub, halt ]

vm.load_program(prog)
# puts vm.inspect

vm.run

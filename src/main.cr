require "./stack-vm"

vm = StackVM.new
add : UInt32 = 0x40000001
halt : UInt32 = 0x40000000
prog : Array(UInt32) = [ 3.to_u, 4.to_u, add, halt ]

vm.load_program(prog)
# puts vm.inspect

vm.run

def get_type(instruction) : UInt32
  type_mask = 0xC0000000.to_u
  masked = type_mask & instruction
  type : UInt32 = masked >> 30
  type
end
add : UInt32 = 0b10000000000000000000000000000001
halt : UInt32 = 0x40000000

puts get_type(add).to_s

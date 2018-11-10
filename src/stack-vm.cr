# TODO: Write documentation for `Stack::Vm`
# module Stack::Vm
#   VERSION = "0.1.0"

  class StackVM
    property program_counter : UInt32, data_pointer, data, program, typ : UInt32, dat : UInt32, running : Bool

    def initialize
      @running = true
      @program_counter = 0
      @data_pointer = 0
      @data = Array(UInt32).new
      @program = Array(UInt32).new
      @typ = 0
      @dat = 0
    end

    def get_type(instruction) : UInt32
      type_mask = 0xC0000000.to_u
      (type_mask & instruction).to_u >> 30
    end

    def get_data(instruction) : UInt32
      data_mask = 0x3FFFFFFF.to_u
      data_mask & instruction
    end

    def decode(instruction)
      typ = get_type(instruction)
      dat = get_data(instruction)
      puts "typ, dat [" + typ.to_s + "," + dat.to_s + "]"
      [typ, dat]
    end

    def execute(typ, dat)
      if typ == 0 || typ == 2
        @data.push dat
      else
        do_primitive(dat)
      end
    end

    def do_primitive(dat)
      case dat
      when 0 # halt
        puts "halt"
        @running = false
      when 1 # add
        puts "adding", @data[0], @data[1]
        result = @data.pop + @data.pop
        @data.push(result)
      end
    end

    def run
      @program.each_with_index do |instruction, idx|
        puts "running instruction " + idx.to_s
        step(instruction)
        display_machine(idx)
        break if !@running
      end
    end

    def step(instruction)
      typ, dat = decode(instruction)
      execute(typ, dat)
    end

    def display_machine(instruction_idx)
      puts "-"*35
      puts "program".ljust(30) + "program_pointer"
      @program.each_with_index do |instr, idx|
        pointer = idx == instruction_idx ? "<-" : ""
        puts instr.to_s(base: 16) + pointer
      end

      puts "data".ljust(30) + "data_pointer"
      @data.each do |datum|
        puts datum.to_s(base: 16)
      end
      puts "-"*35

    end

    def load_program(prog : Array(UInt32))
      @program = prog
      display_machine(0)
    end
  end
# end

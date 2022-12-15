require "wasmer"

module Wasmer::Hello
  VERSION = "0.1.0"

  # Get WASM module file path from the program arguments.
  wasm_module_path = ARGV.first {
    abort "WASM module path is required to continue."
  }
  
  # Define the default engine store.
  store = Wasmer.default_engine.new_store
  
  # Compile the module to be able to execute it!
  wasm_module = Wasmer::Module.new store, File.read(wasm_module_path)
  
  # Now the module is compiled, we can instantiate it.
  instance = Wasmer::Instance.new wasm_module
  
  # Get the exported `helloFormat` function.
  hello_formatter = instance.function("helloFormat").not_nil!
  
  # Call the `helloFormat` function from module and print its result.
  puts hello_formatter.call("Crystal")
end

require 'tmpdir'

BUILD_CONFIG='Debug'
BUILD_DIR=File.expand_path('./build/')

def sdk_dir(version)
  xcode_developer_dir = `xcode-select -print-path`.strip
  "#{xcode_developer_dir}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{version}.sdk"
end

def with_env_vars(env_vars)
  old_values = {}
  env_vars.each do |key,new_value|
    old_values[key] = ENV[key]
    ENV[key] = new_value
  end

  yield

  env_vars.each_key do |key|
    ENV[key] = old_values[key]
  end
end

def system_or_exit(cmd)
  puts "Run: #{cmd}"
  system(cmd) or exit 1
end

def build(options={})
  kwargs = options.map { |key, value| "-#{key} #{value}" }.join(' ')
  system_or_exit "xcodebuild #{kwargs} clean build SYMROOT=#{BUILD_DIR.inspect}"
end

def ios_sim(app, options={}, env={})
  kwargs = options.map { |key, value| "--#{key} #{value == true ? '' : value.inspect}" }.join(' ')
  envs = env.map { |key, value| "--setenv #{key}=#{value.inspect}" }.join(' ')
  system_or_exit "ios-sim launch #{app} #{kwargs} #{envs}"
end

desc 'Builds static lib for ios'
task :build_ios do
  build(
    project: 'JKVValue.xcodeproj',
    scheme: 'JKVValue',
    sdk: 'iphonesimulator7.0',
    configuration: BUILD_CONFIG,
  )
end

desc 'Builds specs for mac os x'
task :build_osx_specs do
  build(
    project: 'JKVValue.xcodeproj',
    scheme: 'OSXSpecs',
    sdk: 'macosx10.8',
    configuration: BUILD_CONFIG,
  )
end

desc 'Builds specs for ios'
task :build_ios_specs do
  build(
    project: 'JKVValue.xcodeproj',
    scheme: 'Specs',
    sdk: 'iphonesimulator7.0',
    configuration: BUILD_CONFIG,
  )
end

desc 'Runs OSX Specs'
task :osx_specs => [:build_osx_specs] do
  env_vars = {
    "DYLD_FRAMEWORK_PATH" => File.join(BUILD_DIR, BUILD_CONFIG),
    "CEDAR_REPORTER_CLASS" => "CDRColorizedReporter"
  }
  with_env_vars(env_vars) do
    system_or_exit "#{BUILD_DIR}/#{BUILD_CONFIG}/OSXSpecs"
  end
end

desc 'Run iOS Specs'
task :ios_specs => [:build_ios_specs] do
  sdk_path = sdk_dir('7.0')
  env_vars = {
    "DYLD_ROOT_PATH" => sdk_path,
    "IPHONE_SIMULATOR_ROOT" => sdk_path,
    "CFFIXED_USER_HOME" => Dir.tmpdir,
    "CEDAR_HEADLESS_SPECS" => "1",
    "CEDAR_REPORTER_CLASS" => "CDRColorizedReporter",
  }

  ios_sim_params = {
    family: 'iphone',
    sdk: 7.0,
    retina: true,
    tall: true
  }

  ios_sim(
    File.join(BUILD_DIR, "#{BUILD_CONFIG}-iphonesimulator", 'Specs.app'),
    ios_sim_params,
    env_vars
  )
end

task :default => [:osx_specs, :ios_specs]
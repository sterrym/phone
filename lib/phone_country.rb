class PhoneCountry < Struct.new(:name, :country_code, :char_2_code, :area_code)
  cattr_accessor :all
  
  YML_FILE = File.join(File.dirname(__FILE__), '..', 'data', 'phone_countries.yml')
  CSV_FILE = File.join(File.dirname(__FILE__), '..', 'data', 'phone_countries.csv')

  def self.load
    return @@all if @@all.present?
    
    data_file = YML_FILE
    
    @@all = {}
    YAML.load(File.read(data_file)).each_pair do |key, c|
      @@all[key] = PhoneCountry.new(c[:name], c[:country_code], c[:char_2_code], c[:area_code])
    end
    @@all
  end
  
  def to_s
    name
  end
  
  def self.find_by_country_code(code)
    @@all[code]    
  end
  
  def country_code_regexp
    Regexp.new("^[+]#{country_code}")    
  end
end

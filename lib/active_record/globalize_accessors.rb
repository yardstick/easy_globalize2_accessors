module ActiveRecord
  module GlobalizeAccessors
    def self.included(base)
      base.extend ActMethods
    end
    
    module ActMethods
      def globalize_accessors(language_codes, attr_names)
        attr_names.each do |attr_name|
          language_codes.each do |locale|
            define_method :"#{attr_name}_#{locale}" do
              send attr_name, locale
            end

            define_method :"#{attr_name}_#{locale}=" do |val|
              val = nil if val.blank?
              
              self.class.with_locale locale do
                send "#{attr_name}=", val
              end
            end
          end
        end  
      end
    end
  end
end

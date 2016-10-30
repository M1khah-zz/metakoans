class Module
  private
    def attribute(var, &block)
      var, default = var.to_a.first if var.is_a?(Hash)

      define_method("#{var}?") do 
        !instance_variable_get("@#{var}").nil?
      end

      define_method("#{var}=") do |arg|
        instance_variable_set("@#{var}", arg)
      end

      define_method("#{var}") do 
        if instance_variable_defined?("@#{var}")
          instance_variable_get("@#{var}")
        else
          instance_variable_set("@#{var}", (block ? instance_eval(&block) : default))
        end
      end
    end
end
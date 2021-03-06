require 'thor'
require 'irb'

require 'space_monkey'

module SpaceMonkey
  class CLI < ::Thor

    desc 'console', 'starts ruby console with client loaded'
    def console
      IRB.setup(nil)
      IRB.singleton_class.send(:remove_method, :setup) # to prevent redefinition warnings
      def IRB.setup(ap_file)
        # redefine it so we reset :SCRIPT config
        conf.delete(:SCRIPT)
        conf[:IRB_NAME] = conf[:AP_NAME] = 'SpaceMonkey'
      end
      IRB.start
    end
  end
end

require 'hashie/extensions/indifferent_access'
require 'hashie/extensions/dash/indifferent_access'
require 'hashie/extensions/ignore_undeclared'

require 'hashie/dash'

module SpaceMonkey
  class Record < Hashie::Dash
    include Hashie::Extensions::Dash::IndifferentAccess
    include Hashie::Extensions::IgnoreUndeclared
  end
end

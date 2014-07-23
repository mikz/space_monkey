require 'hashie/extensions/indifferent_access'
require 'hashie/extensions/dash/indifferent_access'
require 'hashie/dash'

module SpaceMonkey
  class Record < Hashie::Dash
    include Hashie::Extensions::Dash::IndifferentAccess
  end
end

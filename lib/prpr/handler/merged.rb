module Prpr
  module Handler
    class Merged < Base
      handle Event::PullRequest, action: /closed/ do
        Prpr::Action::Merged::Merged.new(event).call
      end
    end
  end
end

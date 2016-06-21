module Prpr
  module Action
    module Merged
      class Merged < Base
        def call
          if merged?
            Publisher::Adapter::Base.broadcast message
          end
        end

        private

        def message
         Prpr::Publisher::Message.new(body: body, from: from, room: room)
        end

        def merged?
          !!event.pull_request.merged_at
        end

        def body
          env.format(:merged_body, event.pull_request)
        end

        def from
          event.sender
        end

        def room
          env[:merged_room]
        end
      end
    end
  end
end

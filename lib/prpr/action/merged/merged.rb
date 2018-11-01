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
          !!pull_request.merged_at
        end

        def head_ref
          pull_request.head.ref
        end

        def base_ref
          pull_request.base.ref
        end

        def customize_params
          Hash[
            html_url: pull_request.html_url,
            title: pull_request.title,
            head: head_ref,
            base: base_ref
          ]
        end

        def pull_request
          event.pull_request
        end

        def body
          env.format(:merged_body, customize_params)
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

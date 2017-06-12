class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(source_provider)
    SourceParser.parse_source_provider(source_provider)
  end
end

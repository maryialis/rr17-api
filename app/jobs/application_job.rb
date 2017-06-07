class ApplicationJob < ActiveJob::Base
  queue_as :default

  def perform(parser, source_provider_id)
    result = parser.constantize.new.parse(File.open('/home/masha/RoR/rr17-api/test/belarusbank.html', encoding: 'windows-1251:utf-8').read)[:result]
    raise "Failed to parse input with parser: #{parser}" unless result
    cr = CourseResult.new(result)
    cr[:source_provider_id] = source_provider_id
    cr.save!
  end
end

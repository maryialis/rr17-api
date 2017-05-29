class AddSourceProviderToCourseResults < ActiveRecord::Migration[5.1]
  def change
    add_reference :course_results, :source_provider, foreign_key: true
  end
end

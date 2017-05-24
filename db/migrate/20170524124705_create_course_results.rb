class CreateCourseResults < ActiveRecord::Migration[5.1]
  def change
    create_table :course_results do |t|
      t.decimal :usd
      t.decimal :eur
      t.decimal :rur
      t.timestamp :created_at

      t.timestamps
    end
  end
end

class CreateSubmitedCandidates < ActiveRecord::Migration
  def change
    create_table :submitted_candidates do |t|
      t.integer :job_id
      t.integer :candidate_id
      t.json :form_json
      t.boolean :accepted
      t.string :progress
    end
  end
end

class AddOrdToWsModelRunsSetModelRuns < ActiveRecord::Migration
  def change
    add_column :ws_model_runs_set_model_runs, :ord, :integer
  end
end

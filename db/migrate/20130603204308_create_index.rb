class CreateIndex < ActiveRecord::Migration
  def change
    %i{multiple_districts districts clubs members offices committees}.each do |table|
      add_index(table, [:year, :oid], :where => 'current')
    end
  end
end
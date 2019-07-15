class CreateWaterinfos < ActiveRecord::Migration[5.0]
  def change
    create_table :waterinfos do |t|
      t.string :name
      t.string :furigana
      t.string :access
      t.string :address
      t.text   :overview
      t.string :imgurl
      t.string :mapurl
      t.timestamps
    end
  end
end

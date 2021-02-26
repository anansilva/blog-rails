class DropActionTextRichTexts < ActiveRecord::Migration[6.1]
  def change
    drop_table :action_text_rich_texts
  end
end

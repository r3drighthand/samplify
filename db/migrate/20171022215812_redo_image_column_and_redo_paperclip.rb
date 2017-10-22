class RedoImageColumnAndRedoPaperclip < ActiveRecord::Migration[5.1]

  def change
    remove_attachment :tracks, :image
    add_attachment :tracks, :image
  end

end

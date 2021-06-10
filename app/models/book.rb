class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	 def favorited_by?(user)
	   self.favorites.where(user_id: user.id).exists?
	 end

	 def self.search(search, word)
	 	 if search == "forward_match"
	 	 	# モデル名.where('カラム名 LIKE?','検索したい文字列%')前方一致
	 	  	@book = Book.where("title LIKE?", "#{word}%")
	 	 elsif search == "backward_match"
	 	 	# モデル名.where('カラム名 LIKE?','%検索したい文字列')後方一致
	 	  	@book = Book.where("title LIKE?", "%#{word}")
	 	 elsif search == "perfect_match"
	 	 	# モデル名.where('検索したい文字列')完全一致
	 	    @book = Book.where("#{word}")
     elsif search == "partial_match"
     	# モデル名.where('カラム名 like ?','%検索したい文字列%')文字列のどの部分にでも検索したい文字列が含まれていればOK
      	@book = Book.where("title LIKE?", "%#{word}%")
     else
      	@book = Book.all
      end
   end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end

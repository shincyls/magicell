class Register < ApplicationRecord

    validates :full_name, presence: {message: " must presense."}
    # validates :last_name, presence: {message: " must presense."}
    # validates :drawing_chance, presence: {message: " must be selected."}
    # validates :email, uniqueness: {message: " must be unique."}, format: {with: /.+@.+\..+/, message: " format must be valid."}, presence: {message: " must presence."}

    enum category: ["Registered","Reserved","Others"]
    enum status: ["unprint","printed"]

    @@running_number = WebappContent.find_by(name: "running_number")

    include PgSearch
    pg_search_scope :search_registers, 
    against: [:full_name, :drawing_chance, :ticket_number, :phone_number, :phone_number_2, :identity_number, :status],
    using: [:tsearch]

    def convert_ticket_number
        @convert = sprintf("%03d", @@running_number.value)
        self.ticket_number = @convert
        @@running_number.value += 1
        @@running_number.save
    end

    def convert_category
        self.category = self.holder.to_i
    end

    def convert_full_name
        @convert = self.first_name + " " + self.last_name
    end

    def convert_draw_chance
        if self.purchase >= 20000
            self.drawing_chance = 5
        elsif self.purchase >= 10000
            self.drawing_chance = 3
        else
            self.drawing_chance = 1
        end
    end

end

require "prawn"

class GuestListPdf < Prawn::Document
def initialize(guest, view)
  super(top_margin: 70)
  @creation_date = Time.now.strftime('%d-%m-%Y')
  @guest = guest
  @view = view
  @accepted = Guest.where(:rsvp => 'accepted').count.to_s
  guest_list_number
  guests_on_the_list
  total_number
end

def guest_list_number
  text "Guest List", size: 30, style: :bold
  text "Date of print:  " + @creation_date
end

def guests_on_the_list
  move_down 20
  table guests_rows do
    row(0).font_style = :bold
    column(0).font_style = :bold
    columns(2..4).align = :center
    columns(5).align = :left
    self.row_colors = ["DDDDDD", "FFFFFF"]
    self.header = true
  end
end

def guests_rows
  [["","Name", "Relationship","Invitation sent","RSVP", "Special Food Requirements" ]] +
      @guest.map  do |item|
        [item.id, item.first_name+" "+item.last_name, item.relationship, item.invitation_sent, item.rsvp, item.spec_food_req]
      end
end


def total_number
  move_down 15
  text "Number of accepted invitations: " + @accepted, size: 16, style: :bold
end
end
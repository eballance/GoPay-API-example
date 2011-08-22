ActiveRecord::Schema.define(:version => 0) do

  create_table "orders", :force => true do |t|
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "payment_data"
    t.text "delivery_data"
    t.float "price"
    t.boolean "payed", :default => false
  end

end

ActiveRecord::Schema.define(:version => 0) do

  create_table "orders", :force => true do |t|
    t.string "state"
    t.string "payment_method_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "payment_data"
    t.text "delivery_data"
    t.float "price"
    t.string "name"
    t.string "payment_session_id"
    t.boolean "payed", :default => false
  end

end

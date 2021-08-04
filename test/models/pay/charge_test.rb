require "test_helper"

class Pay::Charge::Test < ActiveSupport::TestCase
  test "belongs to a Pay::Customer" do
    assert_equal Pay::Customer, pay_charges(:stripe).customer.class
  end

  test "validates charge uniqueness by Pay::Customer and processor ID" do
    user = users(:stripe)
    user.payment_processor.charges.create!(amount: 1, processor_id: "1")
    assert_raises ActiveRecord::RecordInvalid do
      user.payment_processor.charges.create!(amount: 1, processor_id: "1")
    end
  end

  test "#charged_to" do
    assert_equal "VISA (**** **** **** 4242)", pay_charges(:stripe).charged_to
  end

  test "stores data about the charge" do
    charge = pay_charges(:stripe)
    data = {"foo" => "bar"}
    charge.update(data: data)
    assert_equal data, charge.data
  end
end

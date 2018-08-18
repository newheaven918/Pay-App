module Pay
  module Billable
    module Braintree
       def braintree_customer
         if processor_id?
           ::Braintree::Customer.find(processor_id)
         else
           result = ::Braintree::Customer.create(email: email)

           raise StandardError, result.inspect unless result.success?
           update(processor: 'braintree', processor_id: result.customer.id)

           result.customer
         end
       end

      # def create_braintree_subscription(name = 'default')
      #   token = braintree_customer.payment_methods.find(&:default?).token

      #   result = ::Braintree::Subscription.create(
      #     payment_method_token: token,
      #     plan_id: plan
      #   )

      #   if result.success?
      #     subscription = subscriptions.create(
      #       name: name || 'default',
      #       processor: processor,
      #       processor_id: result.subscription.id,
      #       processor_plan: plan,
      #       trial_ends_at: ,
      #       quantity: quantity || 1,
      #       ends_at: nil
      #     )
      #   else
      #     raise StandardError, result.inspect
      #   end

      #   subscription
      # end

      # def update_braintree_card(token)
      #   # Placeholder
      # end
    end
  end
end

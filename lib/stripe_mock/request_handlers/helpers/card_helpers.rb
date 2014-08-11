module StripeMock
  module RequestHandlers
    module Helpers

      def get_customer_card(customer, token)
        customer[:cards][:data].find{|cc| cc[:id] == token }
      end

      def add_card_to_customer(card, cus)
        card[:customer] = cus[:id]
       
        #if cus[:cards][:count] == 0
        #  
        #else
        #  cus[:cards][:data].reject!{|c| c[:id] == cus[:default_card]}
        #end
        cus[:cards][:count] += 1
        
        cus[:cards][:data] << card
        
        card
      end

    end
  end
end
require 'pry'

class Transfer

attr_reader :sender, :receiver, :amount
attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    #run bank checks - use valid, check if the balance is greater than amount being transferred
    if valid? && sender.balance > amount && self.status == "pending"
      #add the amount to the receiver's bank account and subtract from the sender's bank account
      receiver.balance += amount
      sender.balance -= amount
      #change transfer status to complete
      self.status = "complete"
    elsif valid? == false || sender.balance < amount || self.status != "pending"
      #keep status as pending
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    #only completed transfers can be reversed
    if valid? && receiver.balance > amount && self.status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      #keep status as pending
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end





end

class Transfer
  attr_reader :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amt)
    @sender = sender
    @receiver = receiver
    @amount = amt
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance > @amount
  end

  def execute_transaction
    if !valid?
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    elsif status == 'pending'
      sender.balance -= amount
      receiver.balance += amount
      @status = "complete"
    end
  end

  def reverse_transfer
    if status == 'complete'
      sender.balance += amount
      receiver.balance -= amount
      @status = 'reversed'
    end
  end
end

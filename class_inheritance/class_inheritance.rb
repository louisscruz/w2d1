class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def set_manager(manager)
    @boss = manager
    manager.update_subordinates(self)
  end

  def has_employee?
    !@subordinates.nil?
  end
end

class Manager < Employee
  attr_reader :subordinates
  def initialize(name, title, salary, boss = nil, subordinates = [])
    @subordinates = subordinates
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    multiplier * find_total_salary
  end

  def update_subordinates(employee)
    @subordinates << employee unless @subordinates.include?(employee)
  end

  def find_total_salary
    unless @subordinates.nil?
      total_salary = 0
      @subordinates.each do |employee|
        total_salary += employee.salary
        if employee.has_employee?
          total_salary += employee.find_total_salary
        end
      end
      total_salary
    end
  end

end

ned = Manager.new("ned", "boss", 1000000)
darren = Manager.new("darren", "manager", 78000)
shawna = Employee.new("shawna", "emp", 12000)
david = Employee.new("david", "emp", 10000)

david.set_manager(darren)
darren.set_manager(ned)
shawna.set_manager(darren)

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)

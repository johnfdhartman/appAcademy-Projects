class Employee

  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss

  end

  def bonus(multiplier)
    @salary * multiplier
  end


end


class Manager < Employee
  attr_reader :employees


  def initialize(name , title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_employee = @employees.inject(0) {|ac, el| ac + el.salary}
    (total_subordinate_salary - @salary)*multiplier
  end

  def total_subordinate_salary
    salary = self.salary
    self.employees.each do |el|
      if el.class == Manager
        salary += el.total_subordinate_salary
      else
        salary += el.salary
      end
    end
    salary
  end
end

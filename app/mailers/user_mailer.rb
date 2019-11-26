class UserMailer < ApplicationMailer

    def forgot_password(user)
        @user = User.find(user)
        @email = @user.employee.company_email
        @greeting = "Hello!"
        mail(to: @email, :subject => 'Magicell Magicnet Password Reset')
    end

    def make_account(user)
        @user = User.find(user)
        @email = @user.employee.company_email
        mail(to: @email, :subject => 'Magicell Admin has created user login account for you.')
    end

    # When Employee submitted form, this will send notification to Manager.
    def submit_leave(id, mgr)
        @leaveap = Leaveap.find(id)
        @whofrom = @leaveap.employee.full_name
        if mgr == 1
            @mailto = @leaveap.apv_mgr_1.company_email
            @whoto = @leaveap.apv_mgr_1.full_name
        elsif mgr == 2
            @mailto = @leaveap.apv_mgr_2.company_email
            @whoto = @leaveap.apv_mgr_2.full_name
        end
        @title = "[Magicell] Leave Application from #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    def submit_expense(id)
        @expense = ExpenseApproval.find(id)
        @whofrom = @expense.employee.full_name
        @mailto = @expense.manager.company_email
        @whoto = @expense.manager.full_name
        @title = "[Magicell] Expenses Claim Application from #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    def submit_timesheet(id)
        @timesheet = TimesheetApproval.find(id)
        @whofrom = @timesheet.employee.full_name
        @mailto = @timesheet.manager.company_email
        @whoto = @timesheet.manager.full_name
        @title = "[Magicell] Timesheet Application from #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    # When Manager approved form, this will send notification to Employee.
    def approve_leave(id, mgr)
        @leaveap = Leaveap.find(id)
        @mailto = @leaveap.employee.company_email
        @whoto = @leaveap.employee.full_name
        if mgr == 1
            @whofrom = @leaveap.apv_mgr_1.full_name
        elsif mgr == 2
            @whofrom = @leaveap.apv_mgr_2.full_name
        end
        @title = "[Magicell] Leave Application approved by #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    def approve_expense(id)
        @expense = ExpenseApproval.find(id)
        @whofrom = @expense.manager.full_name
        @mailto = @expense.employee.company_email
        @whoto = @expense.employee.full_name
        @title = "[Magicell] Expenses Claim Application approved by #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    def approve_timesheet(id)
        @timesheet = TimesheetApproval.find(id)
        @whofrom = @timesheet.manager.full_name
        @mailto = @timesheet.employee.company_email
        @whoto = @timesheet.employee.full_name
        @title = "[Magicell] Timesheet Application approved by #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    # When Manager rejected form, this will send notification to Employee.
    def reject_leave(id, mgr)
        @leaveap = Leaveap.find(id)
        @mailto = @leaveap.employee.company_email
        @whoto = @leaveap.employee.full_name
        if mgr == 1
            @whofrom = @leaveap.apv_mgr_1.full_name
        elsif mgr == 2
            @whofrom = @leaveap.apv_mgr_2.full_name
        end
        @title = "[Magicell] Leave Application rejected by #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    def reject_expense(id)
        @expense = ExpenseApproval.find(id)
        @whofrom = @expense.manager.full_name
        @mailto = @expense.employee.company_email
        @whoto = @expense.employee.full_name
        @title = "[Magicell] Expenses Claim Application rejected by #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

    def reject_timesheet(id)
        @timesheet = TimesheetApproval.find(id)
        @whofrom = @timesheet.manager.full_name
        @mailto = @timesheet.employee.company_email
        @whoto = @timesheet.employee.full_name
        @title = "[Magicell] Timesheet Application rejected by #{@whofrom}."
        mail(to: @mailto, :subject => @title)
    end

end
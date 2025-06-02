CREATE PROCEDURE GetSalary
    -- filtre facultatif lors de l'execurtion de la procedure
    @id_employee INT = NULL,
    @salDate DATE = NULL
AS
BEGIN
    -- les table t_salary et t_employee sont respectivement abréger en s et e
    SELECT 
        s.id_salary,
        s.salDate,
        s.sal_grossSalary,
        s.sal_netSalary,
        e.id_employee,
        e.empFirstName,
        e.empLastName
    FROM 
        t_salary s
    -- relier les deux tables grace à l'id_employee
    INNER JOIN 
        t_employee e ON s.id_employee = e.id_employee
    WHERE 
        (@id_employee IS NULL OR s.id_employee = @id_employee)
        AND (@salDate IS NULL OR s.salDate = @salDate);
END;
GO

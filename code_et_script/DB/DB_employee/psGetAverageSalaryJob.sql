CREATE PROCEDURE GetAverageSalaryJob
AS
BEGIN
    -- les table t_salary, t_employee et t_job sont respectivement abréger en s, e et j
    SELECT 
        j.id_job,
        j.job_name,
        COUNT(e.id_employee) AS number_employees,
        SUM(s.sal_grossSalary) AS gross_payroll,
        SUM(s.sal_netSalary) AS net_payroll,
        AVG(s.sal_grossSalary) AS average_gross_payroll,
        AVG(s.sal_netSalary) AS average_net_payroll
    FROM 
        t_job j
    -- récupère toutes les lignes de la table t_job, et les employers qui correspondent grace à id_job (même les jobs sans employeés)
    LEFT JOIN 
        t_employee e ON e.id_job = j.id_job
    -- relie les tables t_employee et t_salary par id_employee
    LEFT JOIN 
        t_salary s ON s.id_employee = e.id_employee
    -- regroupe les résultat par métier
    GROUP BY 
        j.id_job, j.job_name
    -- trie par la masse salariale décroisante 
    ORDER BY 
        masse_salariale_brute DESC;
END;
GO

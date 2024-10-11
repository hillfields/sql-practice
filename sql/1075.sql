SELECT 
    project_id,
    ROUND(AVG(experience_years), 2) AS average_years
FROM project
LEFT JOIN employee
    ON project.employee_id = employee.employee_id
GROUP BY project_id;
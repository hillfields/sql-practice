-- get the number of exams for each student x subject combo
WITH exam_attendance AS (
    SELECT 
        student_id, 
        subject_name, 
        COUNT(*) AS attended_exams
    FROM examinations
    GROUP BY student_id, subject_name
)

SELECT
    students.student_id,
    students.student_name,
    subjects.subject_name,
    IFNULL(exam_attendance.attended_exams, 0) AS attended_exams
-- cross join to get each student x subject combo
FROM students
CROSS JOIN subjects
LEFT JOIN exam_attendance
    ON students.student_id = exam_attendance.student_id
    AND subjects.subject_name = exam_attendance.subject_name
ORDER BY students.student_id, subjects.subject_name;
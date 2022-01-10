const express = require("express");
const mysql = require("mysql2");
const nanoid = require("nanoid");

// Should be kept as environment variable
const mysqlConfig = {
  host: process.env.MYSQL_DATABASE || "mysql_server",
  user: process.env.MYSQL_USER || "admin",
  password: process.env.MYSQL_PASSWORD || "secret",
  database: process.env.MYSQL_ROOT_PASSWORD || "seniors",
};

const port = process.env.PORT || 3000;

// Connecting to mysql container
const con = mysql.createConnection(mysqlConfig);
con.connect(function (err) {
  if (err) throw err;
  console.log("connected");
});

const app = express();

app.get("/", function (req, res) {
  res.send("Testing my server");
});

/*
GET /:teacherID
GET /:classID
GET /:pupilID
GET /:classID
Will reply with information about the specific object
*/

// GET /:teacherID
app.get("/fetch/:teacherID", function (req, res) {
  const sql = `SELECT * FROM teachers where id=${req.params.teacherID}`;
  con.query(sql, function (err, result, fields) {
    console.log(result);
    if (err) throw err;
    res.send(JSON.stringify(result));
  });
});

// GET /:classID
app.get("/fetch/:classID", function (req, res) {
  const sql = `SELECT * FROM classes where id=${req.params.classID}`;
  con.query(sql, function (err, result, fields) {
    console.log(result);
    if (err) throw err;
    res.send(JSON.stringify(result));
  });
});

// GET /:studentsID
app.get("/fetch/:studentsID", function (req, res) {
  const sql = `SELECT * FROM students where id=${req.params.studentsID}`;
  con.query(sql, function (err, result, fields) {
    console.log(result);
    if (err) throw err;
    res.send(JSON.stringify(result));
  });
});

// GET /:subjectID
app.get("/fetch/:subjectID", function (req, res) {
  const sql = `SELECT * FROM subjects where id=${req.params.subjectID}`;
  con.query(sql, function (err, result, fields) {
    console.log(result);
    if (err) throw err;
    res.send(JSON.stringify(result));
  });
});

/*
POST /new/pupil
POST /new/teacher
Will create a new object at the correct table with information in the req.body
*/

// POST /new/student
app.post("/new/student", function (req, res) {
  const sql = `insert into students (ID, first_name, last_name) VALUES (${nanoid()}, ${
    req.body.first_name
  },${req.body.last_name})`;

  con.query(sql, function (err, result) {
    if (err) throw err;
    res.send(`created`);
  });
});

// POST /new/teacher
app.post("/new/teacher", function (req, res) {
  const sql = `insert into teachers (id, name, last_name,age) VALUES (${nanoid()}, ${
    req.body.name
  },${req.body.last_name},${req.body.age})`;

  con.query(sql, function (err, result) {
    if (err) throw err;
    res.send(`created`);
  });
});

/*
PUT /update/pupil/:pupilID
PUT /update/class/:classID
Will update the object at the correct table with information in the req.body
*/

// PUT /update/pupil/:pupilID
app.put("/update/student/:studentID", function (req, res) {
  const sql = `update students set last_name=${req.body.last_name} where ID=${req.params.studentID}`;
  con.query(sql, function (err, result) {
    if (err) throw err;
    res.send(`updated`);
  });
});

// PUT /update/class/:classID
app.put("/update/class/:classID", function (req, res) {
  const sql = `update classes set class_name=${req.body.class_name} where ID=${req.params.classID}`;
  con.query(sql, function (err, result) {
    if (err) throw err;
    res.send(`updated`);
  });
});

/*
DELETE /remove/pupil/:pupilID
DELETE /remove/teacher/:teacher
Will delete the object at the correct table.
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';

*/
// DELETE /remove/pupil/:pupilID
app.put("/remove/student/:studentID", function (req, res) {
  const sql = `delete from students where ID=${req.params.pupilID}`;
  con.query(sql, function (err, result) {
    if (err) throw err;
    res.send(`deleted`);
  });
});

// DELETE /remove/teacher/:teacher
app.put("/remove/teacher/:teacher", function (req, res) {
  const sql = `delete from teachers where ID=${req.params.teacher}`;
  con.query(sql, function (err, result) {
    if (err) throw err;
    res.send(`deleted`);
  });
});

app.listen(port, () => {
  console.log(`running on ${port}`);
});

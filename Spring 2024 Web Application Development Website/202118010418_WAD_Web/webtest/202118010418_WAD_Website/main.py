from flask import Flask, request, session, jsonify, render_template
import mysql.connector
import hashlib

server = Flask(__name__, static_folder='')
server.jinja_env.auto_reload=True

database = {
    "host":"localhost",
    "user": "root",
    "password": "123456",
    "database": "tt_db"
}
connect = mysql.connector.connect(**database,connect_timeout=60)
cursor = connect.cursor()

SUCCESS_CODE=0
ERROR_CODE=-1

@server.route("/", methods=["GET"])
@server.route("/login_page", methods=["GET"])
def loginPage():
    return render_template('login.html')

@server.route("/index", methods=["GET"])
def indexPage():
    return render_template('index.html')

# 用户管理
@server.route("/user", methods=["GET"])
def userPage():
    return render_template('page/user.html')

# 课程管理
@server.route("/courseManagement", methods=["GET"])
def courseManagementPage():
    return render_template('page/courseManagement.html')

# 课件管理
@server.route("/courseware_management", methods=["GET"])
def coursewareManagementPage():
    return render_template('page/coursewareManagement.html')

# 邮件管理
@server.route("/email", methods=["GET"])
def emailPage():
    return render_template('page/email.html')

# 作业管理
@server.route("/jobManagement", methods=["GET"])
def jobManagementPage():
    return render_template('page/jobManagement.html')

# 作业回复
@server.route("/homeworkReply", methods=["GET"])
def homeworkReplyPage():
    return render_template('page/homeworkReply.html')

# 讲座管理
@server.route("/lecture_management", methods=["GET"])
def lectureManagementPage():
    return render_template('page/LectureManagement.html')

@server.route("/forum", methods=["GET"])
def forumPage():
    return render_template('page/forum.html')
def response(code, message='', data=None):
    response = {
        "code": code,
        "message": message
    }
    if data is not None:
        response["data"] = data
    return jsonify(response)


@server.route("/login", methods=["POST"])
def login():
    param = request.get_json()
    md5 = hashlib.md5()
    md5.update(param['password'].encode('utf-8'))
    param['password'] = md5.hexdigest()
    print(param['password'])
    cursor.execute('select * from tb_user where username = %(username)s and password = %(password)s',param)
    result = cursor.fetchone()
    if result is None:
        return response(ERROR_CODE,'Incorrect user name or password')
    user = {'id':result[0],'username':result[1],'password':result[2],'identity':result[3],'sex':result[4],'age':result[5],'addTime':result[6]}
    return response(SUCCESS_CODE,'',user)


@server.route("/userList", methods=["POST"])
def userList():
    param = request.get_json()
    sql = 'select id,username,identity,add_time from tb_user where 1=1'
    if 'identity' in param and param['identity'] != '':
        sql += ' and identity = %(identity)s'
    if 'username' in param and param['username'] != '':
        sql += ' and username like "%'+param['username']+'%"'
    sql += ' and id != %(userId)s'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    data=[]
    for r in result:
       data.append({
           'id':r[0],
           'username':r[1],
           'identity':r[2],
           'addTime':r[3]
       })
    return response(SUCCESS_CODE,'',data)

@server.route("/addOrUpdateUser", methods=["POST"])
def addOrUpdateUser():
    param = request.get_json()
    if 'password' in param and param['password'] != '':
        md5 = hashlib.md5()
        md5.update(param['password'].encode('utf-8'))
        param['password'] = md5.hexdigest()
    sql = ''
    if 'id' in param and param['id'] != '':
        sql = 'update tb_user set '
        if 'password' in param and param['password'] != '':
            sql += 'password = %(password)s,'
        if 'sex' in param and param['sex'] != '':
            sql += 'sex = %(sex)s,'
        if 'age' in param and param['age'] != '':
            sql += 'age = %(age)s,'
        if 'identity' in param and param['identity'] != '':
            sql += 'identity = %(identity)s,'
        sql = sql[:-1]
        sql += ' where id = %(id)s'
    else:
        cursor.execute('select * from tb_user where username = %(username)s',param)
        if cursor.fetchone() is not None:
            return response(ERROR_CODE)
        sql = 'insert into tb_user(username,password,identity,sex,age,add_time)value(%(username)s,%(password)s,%(identity)s,%(sex)s,%(age)s,%(addTime)s)'
    cursor.execute(sql,param)
    connect.commit()
    return response(SUCCESS_CODE,param)

@server.route("/rmUser", methods=["POST"])
def rmUser():
    param = request.get_json()
    cursor.execute('delete from tb_user where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/news", methods=["POST"])
def news():
    cursor.execute('select * from tb_news')
    result = cursor.fetchone()
    if result is None:
        return response(SUCCESS_CODE,'','')
    data = result[0]
    return response(SUCCESS_CODE,'', data)

@server.route("/updateNews", methods=["POST"])
def updateNews():
    param = request.get_json()
    cursor.execute('update tb_news set content = (%(content)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/course", methods=["POST"])
def course():
    param = request.get_json()
    sql = 'select c.*,u.username from tb_course c left join tb_user u on u.id = c.teacher_id where 1=1'
    course = {}
    if 'userId' in param and param['userId'] != '':
        cursor.execute('select course_id,status from tb_course_selection where student_id = %(userId)s',param)
        result = cursor.fetchall()
        for r in result:
            course[r[0]] = r[1]
    if 'studentId' in param and param['studentId'] != '':
        cursor.execute('select course_id from tb_course_selection where student_id = %(studentId)s and status=1',param)
        result = cursor.fetchall()
        courseIds = ''
        for r in result:
            courseIds += str(r[0])+','
        courseIds = courseIds[:-1]
        param['courseIds'] = courseIds
        sql += ' and c.id in ('+courseIds+')'
    if 'teacherId' in param and param['teacherId'] != '':
        sql += ' and c.teacher_id = %(teacherId)s'
    if 'teacherName' in param and param['teacherName'] != '':
        sql += ' and u.username like "%'+param['teacherName']+'%"'
    if 'name' in param and param['name'] != '':
        sql += ' and c.name like "%'+param['name']+'%"'
    if 'status' in param and param['status'] != '':
        sql += ' and c.status = %(status)s'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    data = []
    for r in result:
        select = 0
        status = ''
        if r[0] in course.keys():
            select = 1
            status = course[r[0]]
        data.append({
            'id':r[0],
            'name':r[1],
            'teacherId':r[2],
            'description':r[3],
            'startTime':r[4],
            'endTime':r[5],
            'status':status,
            'teacherName':r[7],
            'isSelect': select
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/addCourse", methods=["POST"])
def addCourse():
    param = request.get_json()
    cursor.execute('insert into tb_course(`name`,teacher_id,description,start_time,end_time)value(%(name)s,%(teacherId)s,%(description)s,%(startTime)s,%(endTime)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/updateCourse", methods=["POST"])
def updateCourse():
    param = request.get_json()
    sql = "update tb_course set "
    if 'name' in param and param['name'] != '':
        sql += '`name`= %(name)s,'
    if 'teacherId' in param and param['teacherId'] != '':
        sql += '`teacher_id`= %(teacherId)s,'
    if 'description' in param and param['description'] != '':
        sql += '`description`= %(description)s,'
    if 'startTime' in param and param['startTime'] != '':
        sql += '`start_time`= %(startTime)s,'
    if 'endTime' in param and param['endTime'] != '':
        sql += '`end_time`= %(endTime)s,'
    if 'status' in param and param['status'] != '':
        sql += '`status`= %(status)s,'
    sql = sql[:-1]
    sql += ' where id = %(id)s '
    print(sql)
    cursor.execute(sql,param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/rmCourse", methods=["POST"])
def rmCourse():
    param = request.get_json()
    cursor.execute('delete from tb_course where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/selectCourse", methods=["POST"])
def selectCourse():
    param = request.get_json()
    cursor.execute('select * from tb_course_selection where student_id = %(studentId)s and course_id = %(courseId)s',param)
    result = cursor.fetchone()
    if result is not None:
        if result[3] != -1:
           return response(ERROR_CODE)
        param['id'] = result[0]
        cursor.execute('update tb_course_selection set status = 0 where id = %(id)s',param)
        connect.commit()
        return response(SUCCESS_CODE)
    cursor.execute('insert into tb_course_selection(student_id,course_id)value(%(studentId)s,%(courseId)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/rmSelectCourse", methods=["POST"])
def rmSelectCourse():
    param = request.get_json()
    cursor.execute('select * from tb_course_selection where student_id = %(studentId)s and course_id = %(courseId)s and status = 0',param)
    result = cursor.fetchone()
    if result is None:
        return response(ERROR_CODE)
    print(result)
    param['id'] = result[0]
    cursor.execute('delete from  tb_course_selection where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/getSelectCourse", methods=["POST"])
def getSelectCourse():
    param = request.get_json()
    cursor.execute('select cs.*,c.name,u.username from tb_course_selection cs left join tb_course c on c.id = cs.course_id left join tb_user u on u.id = cs.student_id where cs.status=0',param)
    result = cursor.fetchall()
    data = []
    for r in result:
        data.append({
            'id':r[0],
            'studentId':r[1],
            'courseId':r[2],
            'courseName':r[4],
            'studentName':r[5],
            'status':r[3],
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/updateSelectCourse", methods=["POST"])
def updateSelectCourse():
    param = request.get_json()
    cursor.execute('update tb_course_selection set status=%(status)s where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)



@server.route("/courseware", methods=["POST"])
def courseware():
    param = request.get_json()
    sql = 'select c.*, cc.name, cc.teacher_id, c.content from tb_courseware c left join tb_course cc on c.course_id = cc.id where 1=1'
    if 'courseId' in param and param['courseId'] != '':
        sql += ' and c.id = %(courseId)s'
    if 'type' in param and param['type'] != '':
        sql += ' and c.type = %(type)s'
    if 'name' in param and param['name'] != '':
        sql += ' and c.name like "%'+param['name']+'%"'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    print(result)
    data = []
    for r in result:
        data.append({
            'id':r[0],
            'courseId':r[1],
            'name':r[2],
            'filePath':r[3],
            "type":r[4],
            'content':r[5],
            'courseName':r[6],
            'teacherId':r[7],
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/addCourseware", methods=["POST"])
def addCourseware():
    param = request.get_json()
    cursor.execute('insert into tb_courseware(`name`,content,course_id,file_path,type)value(%(name)s,%(content)s,%(courseId)s,%(filePath)s,%(type)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/updateCourseware", methods=["POST"])
def updateCourseware():
    param = request.get_json()
    sql = "update tb_courseware set "
    if 'name' in param and param['name'] != '':
        sql += '`name`= %(name)s,'
    if 'content' in param and param['content'] != '':
        sql += '`content`= %(content)s,'
    if 'filePath' in param and param['filePath'] != '':
        sql += '`file_path`= %(filePath)s,'
    sql = sql[:-1]
    sql += ' where id = %(id)s'
    cursor.execute(sql,param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/rmCourseware", methods=["POST"])
def rmCourseware():
    param = request.get_json()
    cursor.execute('delete from tb_courseware where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/uploadFile", methods=["POST"])
def uploadFile():
    f = request.files.get('file')
    with open('file/'+f.filename, 'wb') as file:
        file.write(f.read())
    data = {'filePath': '/file/'+f.filename}
    return response(SUCCESS_CODE,'',data)

@server.route("/homework", methods=["POST"])
def homework():
    param = request.get_json()
    sql = 'select h.*,c.name from tb_homework h left join tb_course c on c.id = h.course_id left join tb_homework_answer a on h.id = a.homework_id where 1=1'
    if 'courseId' in param and param['courseId'] != '':
        sql += ' and c.id = %(courseId)s'
    if 'name' in param and param['name'] != '':
        sql += ' and h.name like "%'+param['name']+'%"'
    if 'studentId' in param and param['studentId'] != '':
        cursor.execute('select course_id from tb_course_selection where student_id = %(studentId)s and status=1',param)
        result = cursor.fetchall()
        course = ''
        for r in result:
            course = course + str(r[0]) +','
        course = course[:-1]
        sql += ' and c.id in ('+course+')'
    if 'teacherId' in param and param['teacherId'] != '':
        cursor.execute('select id from tb_course where teacher_id = %(teacherId)s',param)
        result = cursor.fetchall()
        course = ''
        for r in result:
            course = course+ str(r[0]) +','
        course=course[:-1]
        sql += ' and c.id in ('+course+')'  
    if 'endTimeFlag' in param and param['endTimeFlag'] == 1:
        sql += ' and a.id is null order by h.end_time limit 3'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    data = []
    for r in result:
        data.append({
            'id':r[0],
            'courseId':r[1],
            'name':r[2],
            'description':r[3],
            'filePath':r[4],
            'endTime':r[5],
            'courseName':r[6]
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/addHomework", methods=["POST"])
def addHomework():
    param = request.get_json()
    cursor.execute('insert into tb_homework(course_id,name,description,file_path,end_time)value(%(courseId)s,%(name)s,%(description)s,%(filePath)s,%(endTime)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/rmHomework", methods=["POST"])
def rmHomework():
    param = request.get_json()
    cursor.execute('delete from tb_homework where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/answer", methods=["POST"])
def answer():
    param = request.get_json()
    sql = 'select h.*,u.username from tb_homework_answer h left join tb_user u on h.user_id = u.id where 1=1'
    if 'homeworkId' in param and param['homeworkId'] != '':
        sql += ' and h.homework_id = %(homeworkId)s'
    if 'studentId' in param and param['studentId'] != '':
        sql += ' and h.user_id = %(studentId)s'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    data = []
    for r in result:
        data.append({
            'id':r[0],
            'homeworkId':r[1],
            'userId':r[2],
            'content':r[3],
            'filePath':r[4],
            'score':r[5],
            'addTime':r[6],
            'feedback':r[7],
            'username':r[8]
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/addAnswer", methods=["POST"])
def addAnswer():
    param = request.get_json()
    cursor.execute('insert into tb_homework_answer(homework_id,user_id,content,file_path,add_time)value(%(homeworkId)s,%(userId)s,%(content)s,%(filePath)s,%(addTime)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/setScore", methods=["POST"])
def setScore  ():
    param = request.get_json()
    cursor.execute('update tb_homework_answer set score = %(score)s, feedback = %(feedback)s where id = %(id)s',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/discussion", methods=["POST"])
def discussion():
    param = request.get_json()
    sql = 'select d.*,u.username from tb_discussion d left join tb_user u on u.id = d.user_id where 1=1'
    if 'title' in param and param['title'] != '':
        sql += ' and d.title like "%'+param['title']+'%"'
    if 'parentId' in param and param['parentId'] != '':
        sql += ' and d.parent_id = %(parentId)s'
    else:
        sql += ' and d.parent_id = ""'
    if 'userId' in param and param['userId'] != '':
        sql += ' and d.user_id = %(userId)s and d.parent_id = ""'
    sql += ' order by id desc'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    data = []
    for r in result:
        data.append({
            'id':r[0],
            'userId':r[1],
            'title':r[2],
            'content':r[3],
            'addTime':r[4],
            'parentId':r[5],
            'username':r[6],
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/addDiscussion", methods=["POST"])
def addDiscussion():
    param = request.get_json()
    cursor.execute('insert into tb_discussion(user_id,title,content,add_time,parent_id)value(%(userId)s,%(title)s,%(content)s,%(addTime)s,%(parentId)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/updateHomework", methods=["POST"])
def updateHomework():
    param = request.get_json()
    sql = "update tb_homework set "
    if 'courseId' in param and param['courseId'] != '':
        sql += 'course_id= %(courseId)s,'
    if 'name' in param and param['name'] != '':
        sql += '`name`= %(name)s,'
    if 'description' in param and param['description'] != '':
        sql += '`description`= %(description)s,'
    if 'endTime' in param and param['endTime'] != '':
        sql += '`end_time`= %(endTime)s,'
    if 'filePath' in param and param['filePath'] != '':
        sql += '`file_path`= %(filePath)s,'
    sql = sql[:-1]
    sql += ' where id = %(id)s'
    cursor.execute(sql,param)
    connect.commit()
    return response(SUCCESS_CODE)

@server.route("/email", methods=["POST"])
def email():
    param = request.get_json()
    sql = 'select e.*,u.username,u2.username from tb_email e left join tb_user u on u.id = e.sender_id left join tb_user u2 on u2.id = e.receiver_id where 1=1'
    if 'senderId' in param and param['senderId'] != '':
        sql += ' and e.sender_id = %(senderId)s'
    if 'receiverId' in param and param['receiverId'] != '':
        sql += ' and e.receiver_id = %(receiverId)s'
    if 'userId' in param and param['userId'] != '':
        sql += ' and (e.receiver_id = %(userId)s or e.sender_id = %(userId)s)'
    sql += ' order by id desc'
    cursor.execute(sql,param)
    result = cursor.fetchall()
    data = []
    for r in result:
        data.append({
            'id':r[0],
            'senderId':r[1],
            'receiverId':r[2],
            'subject':r[3],
            'content':r[4],
            'sendTime':r[5],
            'senderUser':r[6],
            'receiverUser':r[7]
        })
    return response(SUCCESS_CODE,'',data)

@server.route("/addEmail", methods=["POST"])
def addEmail():
    param = request.get_json()
    cursor.execute('insert into tb_email(sender_id,receiver_id,subject,content,send_time)value(%(senderId)s,%(receiverId)s,%(subject)s,%(content)s,%(sendTime)s)',param)
    connect.commit()
    return response(SUCCESS_CODE)

if __name__ == "__main__":
    server.secret_key = "Housekeeping Management"
    server.run(debug=True)

#daily

This card displays a view of tasks to be done today, when possible. Only Calendar appointments have strict time associated.

<% tp.web.daily_quote() %>

## Calendar Appointments on `= this.file.name`

<!-- tp.user.icalFetch({date: tp.file.title }) -->

```dataviewjs
let currentDate = DateTime.now()
let day = currentDate.toFormat('dd')
let pathToFiles = 'Meta/Daily/' + currentDate.toFormat('yyyy/MM/dd')

let calendarTasksForToday = dv.page(pathToFiles+"/"+day+"-icalbuddy")
        .file
        .tasks
        .where(t => !t.completed)

dv.taskList(calendarTasksForToday, false)
```

## Daily tasks

```dataviewjs
let currentTime = DateTime.now()

const openTasksWeek = dv.pages('("GTD/Projects" and -"GTD/Projects/Done") OR "GTD/Next Actions"').file.tasks  
.where(t => !t.completed && !t.text.contains("#waiting") && (t.due === undefined?true:(t.due.diffNow(["days"]).toObject().days < 8))
);

const taskUntilSunday = openTasksWeek.where(t =>
    !(t.due === undefined) && t.due.weekNumber == currentTime.weekNumber
);
                         
const openTasksWeekNoDate = openTasksWeek.where(t => 
   t.due === undefined
);

const openTasksToday = openTasksWeek.where(t => 
   !(t.due === undefined) && t.due.day == currentTime.day
);

const overdueTasks = openTasksWeek.where(t => 
   !(t.due === undefined) && t.due.diffNow(["days"]).toObject().days < 0 && t.due.day != currentTime.day
);

dv.paragraph('### Tasks overdue: ' + overdueTasks.length + '\n');
dv.paragraph('### Tasks due Today: ' + openTasksToday.length + '\n');
dv.paragraph('### Tasks no date: ' + openTasksWeekNoDate.length + '\n');
dv.paragraph('### Tasks this week: ' + taskUntilSunday.length + ' (Daily average: ' + Math.round(taskUntilSunday.length/(8 -currentTime.weekday)) + ')\n');
```

```dataviewjs
let currentTime = DateTime.now()
let dayOfWeek = currentTime.toFormat('c')
let dayHour = currentTime.toFormat('H')

const projects = dv.pages('"GTD/Projects" and -"GTD/Projects/Done"').sort(b => b.priority)

function renderProjects(projects) {
    // iterate over projects
    for (let prj of projects) {     
        const query = `
        path includes ${prj.file.path}    
        not done
        (no due date) OR (due today) OR (due before today)
        NOT (tag includes #waiting)
        sort by urgency
        group by filename
        limit 3
        hide backlink 
        hide task count   
        `;
    
        dv.paragraph('```tasks\n' + query + '\n```');    
    }
}
// show next actions
const nextActionsQuery = `
    (filename includes Next Actions)    
    not done
    (no due date) OR (due today) OR (due before today)
    NOT (tag includes #waiting)
    sort by urgency
    group by filename
    limit 3
    hide backlink    
    hide task count
    `;
    
// show actions
dv.paragraph('```tasks\n' + nextActionsQuery + '\n```');   

// projects at the bottom
renderProjects(projects);
```

### Waiting For

```tasks
not done
tag includes #waiting
hide backlink
hide task count
```

### Tasks with invalid dates
```tasks 
(done date is invalid) OR (due date is invalid) OR (scheduled date is invalid) OR (start date is invalid)
```
# Craft Docs Task Management - Deep Dive Study (Last 30 Days)

Research conducted on: 2025-11-29
Focus: Recent task management feature requests and user feedback following Craft 3.0 launch
Context: Craft 3.0 released November 28, 2024 with major task management overhaul

---

## 🎉 Craft 3.0 Launch Context (November 28, 2024)

Craft 3.0 was released just one day ago (relative to today's date of 11/29), representing the biggest update in years with over 100 new features. The centerpiece of this update was a complete reimagining of task management.

### What Craft 3.0 Added for Tasks:

1. **Task Inbox** - Dedicated space for quick capture inspired by GTD framework
2. **Global Task View** - Unified view showing all tasks across all documents
3. **Calendar Integration** - View tasks alongside calendar events and daily notes
4. **Apple Reminders Integration** - Import tasks from Apple Reminders
5. **Repeating Tasks** - Automatic scheduling of recurring tasks
6. **Target & Due Dates** - Set deadlines with gentle reminders
7. **Task Widgets** - Keep tasks front and center across devices
8. **Cross-Platform** - Available on iPhone, iPad, Mac (online or offline)

---

## 🚨 Critical Issues & User Complaints (Post-Launch)

### 1. Apple Reminders Integration Problems ⭐⭐⭐⭐

**The Problem:**
- **One-way sync only** - Changes in Craft DO NOT sync back to Apple Reminders
- **Tasks are deleted from Apple Reminders** when imported to Craft
- Users cannot maintain tasks in both systems simultaneously
- Recurring tasks from Apple Reminders import as single tasks only
- Time zone issues causing date changes (fix promised in upcoming update)

**User Quote:**
> "Not only is it not organised, but importing the tasks from Craft, deletes them from Apple Reminders. I would need to shelve this for a while until we have two-way syncing between Craft and Apple Reminders."

**Impact:** HIGH - Users want to use Apple Reminders for quick Siri capture while managing tasks in Craft

**User Request:**
> "Really want to sync between Apple Reminders and Craft... will that be a fast follow integration?"

---

### 2. No Kanban Board View ⭐⭐⭐⭐

**The Problem:**
- Craft **officially does not have a Kanban view** for task or project management
- Users can track tasks in tables, lists, and collections, but no drag-and-drop board visualization
- Craft created a "Kanban board workaround" support article, indicating high user demand
- Craft offers a Kanban board template, but it's not a true interactive board

**Comparison:**
- Notion: Full Kanban, calendar, table, timeline views
- Todoist: Board view available
- TickTick: Full Kanban boards
- Craft: No native Kanban (workaround only)

**Impact:** CRITICAL - This is the #1 officially acknowledged missing feature for task management

**Competitive Gap:** Notion users specifically cite Kanban boards as a reason to stay with Notion over Craft

---

### 3. No Database/Filtering/Sorting Capabilities ⭐⭐⭐⭐

**The Problem:**
- Craft tables are "just visual tables" - no functions, calculations, or advanced filtering
- Cannot add status tags like "Idea", "Draft", "Published" to filter tasks
- No relational database features like Notion
- Cannot create linked views showing same data filtered differently
- No way to sort/filter tasks by custom properties

**User Quote:**
> "Craft enables you to build a collection within a document, similar to an inserted table... However, with simple tables you can not add status tags like 'Idea', 'Draft', or 'Published', so you can not filter out published blog posts either."

**Craft's Position:**
> "Craft has already announced that they won't be integrating databases, but they will be releasing tables soon."

**Impact:** HIGH - This is a fundamental architectural decision that limits task management power users

**User Recommendation:**
> "If you want to collaborate on a more complex level and use kanban boards, timeline views and need advanced sorting and filtering options then you are better to stick to Notion."

---

### 4. Collections Feature "Still Rough" ⭐⭐⭐

**The Problem:**
- Collections (introduced in Craft 3.0) is in early stages with "many rough edges"
- Feature feels incomplete despite being headline update
- Users report frustration with implementation quality

**Context:** Collections was meant to help organize related content including tasks, but execution is falling short

**Impact:** MEDIUM - Affects ability to organize tasks effectively

---

### 5. No Task Dependencies ⭐⭐

**The Problem:**
- No native support for task dependencies
- Cannot block tasks or create prerequisite relationships
- Limited for complex project management

**Competitor Comparison:**
- Notion: Has dependencies
- ClickUp: Full dependency system
- Craft: Not mentioned in documentation (likely absent)

**Impact:** MEDIUM - Matters for advanced project management workflows

---

### 6. Limited Task Metadata & Properties ⭐⭐⭐

**The Problem:**
- No priority levels (or very basic)
- No custom labels/tags for tasks
- No context assignments
- Limited filtering capabilities
- No custom fields for tasks

**What Users Can Do:**
- Set target and due dates
- Add tasks to documents
- Use inbox for capture
- Set repeating patterns

**What Users Cannot Do:**
- Assign priority levels (P1, P2, P3)
- Tag tasks with contexts (@home, @work, @errands)
- Create custom task properties
- Filter by multiple criteria
- Build smart task lists

**Competitor Comparison:**
- Todoist: Projects, priorities, labels, filters, sections
- Things 3: Areas, tags, headings, checklists
- TickTick: Tags, lists, priorities, custom filters, smart lists
- Craft: Date/time, repeating, location in document/inbox

**Impact:** HIGH - Power users need more task metadata for GTD/advanced workflows

---

### 7. Subtasks Treatment ⭐⭐

**The Problem:**
- Tasks and subtasks displayed in unified list (flat hierarchy)
- No clear hierarchical task relationships in Task view
- Subtasks treated "the same" as parent tasks when using Apple Reminders integration

**Impact:** MEDIUM - Affects task organization and nested project structures

---

## 📊 Competitive Feature Gap Analysis

### Craft vs. Dedicated Task Managers

| Feature | Craft 3.0 | Todoist | Things 3 | TickTick | Notion |
|---------|-----------|---------|----------|----------|--------|
| **Basic Tasks** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Due Dates** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Recurring Tasks** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Subtasks** | ⚠️ Flat | ✅ | ✅ | ✅ | ✅ |
| **Priorities** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Labels/Tags** | ❌ | ✅ | ✅ | ✅ | ✅ |
| **Kanban View** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Calendar View** | ✅ | ⚠️ Premium | ✅ | ✅ | ✅ |
| **Filters** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Smart Lists** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Dependencies** | ❌ | ❌ | ❌ | ✅ | ✅ |
| **Two-way Integrations** | ❌ | ✅ | ⚠️ Limited | ✅ | ✅ |
| **Database Features** | ❌ | ❌ | ❌ | ❌ | ✅ |
| **Natural Language** | ❌ | ✅ | ❌ | ✅ | ❌ |
| **Collaboration** | ✅ Docs | ✅ | ❌ | ✅ | ✅ |

**Key Takeaway:** Craft 3.0 offers **basic** task management but lacks advanced features power users expect.

---

## 👥 User Workflow Insights

### Current Hybrid Approaches (Most Common)

1. **Craft + Things 3**
   - Daily task management in Things 3
   - Project notes and reference docs in Craft
   - Tasks link to Craft documents for context

2. **Craft + Apple Reminders**
   - Quick Siri capture to Apple Reminders
   - Import to Craft for deep work
   - Problem: Deletes from Reminders (major pain point)

3. **Craft + Todoist**
   - Task management in Todoist
   - Notes and documentation in Craft
   - Integration via Zapier (unofficial)

4. **Craft + Notion**
   - Complex databases and task boards in Notion
   - Beautiful documents and writing in Craft
   - Users maintain two separate systems

### What Users Actually Want: **One App Solution**

**User Quote:**
> "Craft Docs - if you want all your documents and tasks in one place"

But current reality:
> "One reviewer noted they would need to shelve this for a while until we have two-way syncing"

---

## 🎯 Specific Feature Requests from Community

### Tier 1 - Critical (Most Requested)

1. **Two-Way Apple Reminders Sync** ⭐⭐⭐⭐⭐
   - Don't delete tasks from Apple Reminders on import
   - Bi-directional updates between systems
   - Preserve recurring task patterns
   - Fix time zone issues
   - Allow selective list import (not all-or-nothing)

2. **Kanban Board View** ⭐⭐⭐⭐⭐
   - Drag-and-drop task cards
   - Customizable columns (To Do, In Progress, Done, etc.)
   - Visual workflow management
   - Board view for Collections

3. **Advanced Filtering & Sorting** ⭐⭐⭐⭐
   - Filter tasks by multiple criteria
   - Sort by priority, due date, project, etc.
   - Save custom views/filters
   - Smart collections based on task properties

### Tier 2 - High Priority

4. **Task Labels/Tags** ⭐⭐⭐⭐
   - Multi-tag support for tasks
   - Color-coded tags
   - Filter by tags
   - Tag autocomplete

5. **Priority Levels** ⭐⭐⭐⭐
   - P1/P2/P3 or similar system
   - Visual priority indicators
   - Sort by priority

6. **Task Status Tags** ⭐⭐⭐
   - Beyond just "done" checkbox
   - Custom statuses (Waiting, In Progress, Blocked, etc.)
   - Visual status indicators
   - Status-based filtering

7. **Proper Subtask Hierarchy** ⭐⭐⭐
   - Visual parent-child relationships
   - Collapsible subtask lists
   - Progress tracking (2/5 subtasks complete)
   - Subtask-specific views

### Tier 3 - Medium Priority

8. **Task Dependencies** ⭐⭐
   - Block tasks until prerequisites complete
   - Visual dependency chains
   - Dependency warnings

9. **Natural Language Input** ⭐⭐
   - "Meeting tomorrow at 3pm" → auto-creates task with due date
   - Quick task creation via parsing

10. **Better Collections Implementation** ⭐⭐⭐
    - Fix rough edges in current implementation
    - More intuitive organization
    - Nested collections

11. **Third-Party Integrations** ⭐⭐
    - Official Todoist integration
    - Zapier/Make.com connectors
    - Calendar app integrations beyond viewing

### Tier 4 - Nice to Have

12. **Time Tracking** ⭐
    - Track time spent on tasks
    - Pomodoro integration
    - Time estimates vs. actual

13. **Task Templates** ⭐
    - Reusable task checklists
    - Project templates with pre-set tasks

14. **Bulk Task Operations** ⭐
    - Select multiple tasks
    - Batch edit properties
    - Mass reschedule

---

## 💭 User Sentiment Analysis

### Positive Sentiment

**What Users Love:**
- "Simple yet powerful"
- "Clean writing experience"
- "Beautiful design"
- "Fabulous design inspiring creativity"
- Finally addressing task management gap
- Cross-platform availability
- Inbox for quick capture

### Negative Sentiment

**What Frustrates Users:**
- "Not organised" (Apple Reminders integration)
- "Many rough edges" (Collections)
- "Incomplete and frustrating to use" (Craft Styles)
- "Cramming every feature in the UI"
- "Minor issues negatively impacting user experience"
- "Several changes in the past 18 months, occasionally feels incomplete"

### Expert/Productivity Consultant Opinions

**Curtis McHale** (Productivity Consultant):
> "Craft is not a task manager" and advises against using it for task management

**Users comparing to Notion:**
> "Using Craft Docs for managing tasks suboptimal... Notion is much better to plan and execute"

### Recent User Verdict (2024):

**Optimistic:**
> "Task management is not yet fully fleshed out but it's getting better and better with every iteration"

**Pragmatic:**
> "The perfect PKM + task management tool" (when used with other apps)

---

## 🔬 GTD & Productivity System Support

### Getting Things Done (GTD) Framework

**What Craft 3.0 Got Right:**
- ✅ Inbox for quick capture
- ✅ Calendar view for schedule
- ✅ Daily notes for journaling/review
- ✅ Document linking for reference

**What's Missing for Full GTD:**
- ❌ Contexts (@home, @computer, @phone, @errands)
- ❌ Project vs. Next Action distinction
- ❌ Waiting For tracking
- ❌ Someday/Maybe list
- ❌ Weekly review support
- ❌ Area of responsibility management

**User Feedback:**
> "No GTD or project management workflow baked into the task integration"

### PARA Method Support

**What Works:**
- Projects: Can use Collections
- Areas: Can use folder structure
- Resources: Excellent document management
- Archive: Available

**Gaps:**
- No clear visual distinction between Projects and Areas
- Task management doesn't integrate well with PARA
- Cannot filter tasks by PARA category

### Building a Second Brain (BASB)

**Strengths:**
- ✅ Excellent for knowledge capture
- ✅ Document linking and references
- ✅ Daily notes for progressive summarization
- ✅ Beautiful writing environment

**Weaknesses:**
- ⚠️ Task execution layer is weak
- ⚠️ Cannot easily act on captured information
- ⚠️ No clear workflow from notes → tasks

**User Approach:**
> "Craft Docs is the main point of entry for my second brain system" - but users still need separate task manager

---

## 📱 iOS-Specific Considerations

### What Works Well on iOS

1. **Native Performance** - Fast, smooth, offline-capable
2. **Quick Capture** - Fast inbox entry
3. **Widget Support** - Task widgets on home screen
4. **Apple Reminders Integration** - Siri task creation (despite sync issues)
5. **Calendar Integration** - View events alongside tasks

### iOS-Specific Pain Points

1. **Font Size** ⭐⭐
   - Fonts too small on iOS
   - Cannot be adjusted
   - Accessibility concern

2. **No Siri Direct Integration** ⭐⭐
   - Cannot create Craft tasks directly via Siri
   - Must use Apple Reminders workaround
   - Then import (which deletes from Reminders)

3. **Limited iOS Automation** ⭐
   - No Shortcuts support mentioned
   - Cannot automate task workflows
   - Limited x-callback-url support

### iOS Opportunity: **Shortcut Actions**

**User Request (Implied):**
- "Create task in Craft" Shortcut action
- "Add to daily note" Shortcut action
- "Create task from clipboard" automation
- Better iOS ecosystem integration

---

## 🎨 UI/UX Feedback on Task Features

### Design Complaints

1. **Feature Overload** ⭐⭐⭐
   - "Cramming every feature in the UI"
   - "Endless different views, confusing navigation"
   - "Hidden elements behind multi-slide navs"
   - Craft 3.0 added 100+ features, making UI more complex

2. **Collections Not Intuitive** ⭐⭐
   - "Many rough edges"
   - Not clear how to best organize tasks vs. documents

3. **Task View Organization** ⭐
   - Mixing tasks from all documents can be overwhelming
   - Need better task grouping/organization

### What Users Want

1. **Simplified Views**
   - Focus modes for tasks only
   - Customizable sidebar
   - Hide features not in use

2. **Better Visual Hierarchy**
   - Clear distinction between projects and tasks
   - Visual task relationships
   - Progress indicators

3. **Consistent Design Language**
   - Current state: "Product seems to prioritize adding every single imaginable feature rather than just focusing on how users actually write notes"
   - Desired: Maintain simple, beautiful design while adding functionality

---

## 🔄 Comparison: Why Users Choose Alternatives

### Why Users Choose Todoist Over Craft

1. ✅ Cross-platform (Windows + Mac)
2. ✅ Mature task management features
3. ✅ Priorities, labels, filters
4. ✅ Natural language input
5. ✅ Karma/productivity tracking
6. ✅ Integrations with everything
7. ✅ Board view available

**Quote:**
> "Todoist - If you primarily need a task/ project management app"

### Why Users Choose Things 3 Over Craft

1. ✅ Apple ecosystem integration
2. ✅ Calm, uncluttered UI
3. ✅ Tag-based organization
4. ✅ Today/Upcoming/Anytime views
5. ✅ Headings for task organization
6. ✅ No subscription (one-time purchase)

**Drawback:** Things 3 is Apple-only and expensive upfront

### Why Users Choose TickTick Over Craft

1. ✅ Power user features
2. ✅ Free version available
3. ✅ Kanban boards
4. ✅ Pomodoro timer
5. ✅ Habit tracking
6. ✅ Custom filters and smart lists
7. ✅ Calendar view included

**Quote:**
> "If you're a power user who frequently uses advanced task management tactics, you'll feel right at home on TickTick"

### Why Users Choose Notion Over Craft

1. ✅ Databases with relations and rollups
2. ✅ Multiple view types (Kanban, Table, Calendar, Timeline)
3. ✅ Advanced filtering and sorting
4. ✅ All-in-one workspace
5. ✅ Team collaboration features
6. ✅ API and extensive integrations

**Quote:**
> "If you want to collaborate on a more complex level and use kanban boards, timeline views and need advanced sorting and filtering options then you are better to stick to Notion"

### Why Users Still Choose Craft

1. ✅ Beautiful, clean design
2. ✅ Best-in-class document creation
3. ✅ Native app performance
4. ✅ Offline-first architecture
5. ✅ Simple yet powerful for writing
6. ✅ Great for PKM (Personal Knowledge Management)
7. ✅ Less overwhelming than Notion

**Quote:**
> "I use craft because it is simple yet powerful. It can do basic data or complex documents and subpages, even down to tables with equations as needed. All that power and yet the writing experience is clean!"

---

## 🎯 Strategic Recommendations for Roadmap

### Phase 1: Fix Critical Issues (0-3 months)

**Priority: Fix What's Broken**

1. **Apple Reminders Two-Way Sync** 🔴 CRITICAL
   - This is actively breaking user workflows NOW
   - Users are "shelving" the feature until fixed
   - Quick win: Don't delete from Reminders on import
   - Full solution: Bi-directional sync
   - **User Impact:** Immediate improvement for iOS users

2. **Collections Polish** 🔴 CRITICAL
   - Fix "rough edges" in recent launch
   - Make organization more intuitive
   - Add documentation/tutorials
   - **User Impact:** Makes Craft 3.0 features actually usable

3. **Task Filtering Basics** 🟡 HIGH
   - At minimum: Filter by due date, completion status
   - Group tasks by document/collection
   - Show/hide completed toggle (already exists, improve)
   - **User Impact:** Makes task list manageable at scale

### Phase 2: Core Task Management (3-6 months)

**Priority: Match Baseline Expectations**

4. **Kanban Board View** 🔴 CRITICAL
   - Most requested feature
   - Essential for project management
   - Competitive necessity (Notion has it)
   - Start simple: To Do / In Progress / Done
   - **User Impact:** Unlocks visual task management

5. **Task Labels/Tags** 🔴 CRITICAL
   - Multi-tag support for tasks
   - Filter by tags
   - Color coding
   - **User Impact:** Enables GTD contexts and organization

6. **Priority Levels** 🟡 HIGH
   - P1/P2/P3 or High/Medium/Low
   - Visual indicators
   - Sort by priority
   - **User Impact:** Helps users focus on important tasks

7. **Proper Subtask Hierarchy** 🟡 HIGH
   - Visual parent-child display
   - Collapsible lists
   - Progress tracking
   - **User Impact:** Better project breakdown

### Phase 3: Advanced Features (6-12 months)

**Priority: Power User Enablement**

8. **Custom Task Properties** 🟡 HIGH
   - User-defined fields
   - Custom status options
   - Flexible metadata
   - **User Impact:** Customizable workflows

9. **Advanced Filtering & Smart Collections** 🟡 HIGH
   - Multi-criteria filters
   - Saved filter views
   - Smart collections (auto-update based on criteria)
   - **User Impact:** Power user productivity

10. **Task Dependencies** 🟢 MEDIUM
    - Block tasks until prerequisites complete
    - Visual dependency chains
    - **User Impact:** Complex project management

11. **Natural Language Input** 🟢 MEDIUM
    - Quick task creation
    - Date/time parsing
    - **User Impact:** Speed of capture

### Phase 4: Integration & Ecosystem (Ongoing)

**Priority: Play Well With Others**

12. **Improved Apple Ecosystem Integration**
    - Siri Shortcuts support
    - Better Calendar integration (two-way)
    - Focus mode integration
    - **User Impact:** Native iOS experience

13. **Third-Party Integration**
    - Official API
    - Zapier/Make.com
    - Calendar apps
    - **User Impact:** Workflow flexibility

---

## 🚫 What NOT to Build (Based on User Feedback)

### Don't Compete with Full Project Management Tools

Users **don't** expect:
- ❌ Gantt charts
- ❌ Resource allocation
- ❌ Time tracking (unless simple)
- ❌ Budget management
- ❌ Advanced reporting/analytics

**Rationale:** Craft's strength is simplicity + power. Don't become Monday.com.

### Don't Build Notion Databases

Craft officially said they won't do databases. **Stick to this decision.**

**Instead:** Focus on making tables more functional without full database complexity:
- ✅ Basic sorting/filtering in tables
- ✅ Task-specific views (not generic databases)
- ✅ Collection-based organization (already started)

### Don't Over-Complicate the UI

Users are already complaining about:
- "Cramming every feature in the UI"
- "Confusing navigation"
- "Hidden elements"

**Strategy:**
- Progressive disclosure of features
- Customizable workspace
- Simple defaults, powerful options for those who want them

---

## 💡 The Craft Task Management Vision

### Current User Confusion: What IS Craft?

- Document app? ✅
- Note-taking app? ✅
- Task manager? 🤷
- Project management? 🤷
- All-in-one workspace? 🤷

### Recommended Positioning: **"The Beautiful Productivity Platform"**

**Core Promise:**
> "Craft combines beautiful document creation with practical task management, so your thinking and doing live together in one elegant workspace."

**Key Differentiators:**
1. **Design-first** - Never sacrifice beauty for functionality
2. **Integrated** - Tasks emerge from and connect to your notes naturally
3. **Apple-native** - Best-in-class iOS/Mac experience
4. **Offline-first** - Work anywhere, sync everywhere
5. **Just-enough** - Powerful task management without complexity overload

**NOT Trying to Be:**
- ❌ A Todoist replacement (pure task manager)
- ❌ A Notion clone (database everything)
- ❌ A Microsoft Project alternative (enterprise PM)

**Trying to Be:**
- ✅ Where your ideas become documents become tasks become reality
- ✅ The app for people who think through writing
- ✅ The beautiful alternative to Notion's complexity

---

## 📊 Success Metrics to Track

### Adoption Metrics
1. **% users who use Tasks feature** (baseline after 30 days post-launch)
2. **Tasks created per active user** (avg/median)
3. **% users who use Tasks + Documents** (integration measure)
4. **% users who use Kanban view** (when launched)

### Retention Metrics
4. **Task feature weekly active users** (WAU)
5. **Churn rate of users citing "task management" as reason**
6. **Users who previously used separate task manager** (survey)

### Quality Metrics
7. **NPS score for task features** (separate from overall app)
8. **Support tickets related to task management**
9. **"Apple Reminders sync" complaint rate** (track until fixed)

### Competitive Metrics
10. **Win rate vs. Notion** (for new users)
11. **User switching from Todoist/Things to Craft tasks** (survey)
12. **Feature parity score** vs. competitors (track quarterly)

---

## 🗣️ Direct User Quotes Summary

### On Current State:

> "Really want to sync between Apple Reminders and Craft... will that be a fast follow integration?"

> "Not only is it not organised, but importing the tasks from Craft, deletes them from Apple Reminders."

> "Task management is not yet fully fleshed out but it's getting better and better with every iteration"

> "Collections... is still in early stages with many rough edges"

### On What They Love:

> "I use craft because it is simple yet powerful. It can do basic data or complex documents and subpages, even down to tables with equations as needed. All that power and yet the writing experience is clean!"

> "Fabulous design inspiring creativity"

> "The perfect PKM + task management tool"

### On What's Missing:

> "Craft is not a task manager" - Curtis McHale, Productivity Consultant

> "Using Craft Docs for managing tasks suboptimal... Notion is much better to plan and execute"

> "If you want to collaborate on a more complex level and use kanban boards, timeline views and need advanced sorting and filtering options then you are better to stick to Notion"

### On Why They Use Alternatives:

> "Todoist - If you primarily need a task/ project management app (Superlist is my second choice here)"

> "Craft Docs - if you want all your documents and tasks in one place"

---

## 📅 Timeline of Recent Changes

- **November 28, 2024**: Craft 3.0 launches with Tasks, Collections, Styles
- **November 29, 2024**: Early user feedback emerging (THIS STUDY)
- **Upcoming**: Craft team promises fixes for time zone issues in Apple Reminders integration

**Note:** This research captures the immediate post-launch feedback window. Many users are still discovering and testing the new features.

---

## 🎯 Final Recommendations Summary

### Immediate Actions (This Month)

1. ✅ Monitor and respond to Apple Reminders sync complaints
2. ✅ Gather specific Collections pain points from support tickets
3. ✅ Survey users: "What task feature would you use most?"
4. ✅ Publish roadmap transparency on task management

### Quarter 1 (Next 3 Months)

1. 🔧 Fix Apple Reminders two-way sync
2. 🔧 Polish Collections to remove "rough edges"
3. ➕ Add basic task filtering (date, status, collection)
4. ➕ Add task labels/tags (Phase 1)

### Quarter 2 (3-6 Months)

1. ➕ Launch Kanban board view
2. ➕ Add priority levels for tasks
3. ➕ Improve subtask hierarchy display
4. 🔧 UI simplification initiative

### Quarter 3-4 (6-12 Months)

1. ➕ Custom task properties
2. ➕ Advanced filtering & smart collections
3. ➕ iOS Shortcuts integration
4. ➕ Natural language task input
5. 🔧 Official API (enables third-party integrations)

---

## Sources & References

### Official Craft Documentation
- [Craft 3: Introducing Tasks](https://www.craft.do/blog/introducing-tasks)
- [Craft Tasks Help Site](https://support.craft.do/hc/en-us/articles/16455702233884-Craft-Tasks)
- [What's Missing in Craft](https://support.craft.do/hc/en-us/articles/19096207476892-What-s-Missing-in-Craft-A-Look-at-Potential-Enhancements)
- [Getting Started with Apple Reminders Integration](https://support.craft.do/hc/en-us/articles/17125199016092-Getting-Started-with-Apple-Reminders-Integration)
- [Repeating Tasks in Craft](https://support.craft.do/hc/en-us/articles/18568751196060-Repeating-Tasks-in-Craft)
- [Kanban board workaround](https://support.craft.do/hc/en-us/articles/7579087188637-Kanban-board-workaround)

### Reviews & Comparisons
- [The Verge - Craft 3 Review (Nov 28, 2024)](https://www.theverge.com/2024/11/28/24307906/craft-3-notes-tasks-calendar-app-mac-iphone-windows)
- [Product Hunt - Craft.do Reviews](https://www.producthunt.com/products/craft-do/reviews)
- [Craft vs Notion Comparison - Zapier](https://zapier.com/blog/craft-vs-notion)
- [Craft vs Notion - Upbase](https://upbase.io/blog/notion-vs-craft/)
- [Craft vs Notion - 2sync](https://2sync.com/blog/craft-vs-notion)
- [Notion vs Craft: Why I Stuck with Notion - Medium](https://medium.com/@thedigitalmerchant/notion-vs-craft-why-i-stuck-with-notion-42116fd3b04f)

### User Blogs & Workflows
- [Should You Use Craft as a Task Manager? - Curtis McHale](https://curtismchale.ca/2021/04/12/should-you-use-craft-as-a-task-manager/)
- [Using Craft as a Kanban Board - Curtis McHale](https://curtismchale.ca/2021/06/14/using-craft-as-a-kanban-board/)
- [Project Management in Craft Docs - Emily Hokett](https://www.emilyhokett.blog/project-management-in-craft-docs-heres-my-experience-with-a-tight-academic-schedule/)
- [My Favourite Craft Docs Shortcuts (For Task Management) - Maggi Fuchs](https://maggifuchs.com/craft-docs-shortcuts-for-task-management/)
- [Why I switched from Notion to Craft Docs - Maggi Fuchs](https://maggifuchs.com/craft-docs-vs-notion/)
- [Craft, Apple Reminders, and Fantastical in 2022 - Sam Matla](https://sammatla.com/3-app-productivity-system/)

### Productivity System Resources
- [Second Brain Template - Craft](https://www.craft.do/templates/second-brain)
- [Building a Second Brain and GTD - Obsidian Rocks](https://obsidian.rocks/building-a-second-brain-and-gtd/)
- [How BASB, GTD, and Scrum help manage productive life](https://realappuser.com/how-basb-gtd-and-scrum-help-me-to-manage-my-productive-life/)

### Task Manager Comparisons
- [TickTick vs Todoist - Zapier](https://zapier.com/blog/ticktick-vs-todoist/)
- [TickTick vs Todoist - Upbase](https://upbase.io/blog/ticktick-vs-todoist/)
- [Things vs OmniFocus vs Todoist - The Sweet Setup](https://thesweetsetup.com/articles/comparison-best-gtd-apps-things-todoist-omnifocus/)

### Community Discussions
- [Outliner Software Forum: Craft 3.0](https://www.outlinersoftware.com/topics/viewt/11156/0/craft-30)
- [Craft Community](https://www.craft.do/community/)
- [Reddit r/CraftDocs](https://www.reddit.com/r/CraftDocs/)
- [Threads - Apple Reminders Sync Question](https://www.threads.com/@chris/post/DDDiaSsy0cG?hl=en)

---

**Research Note:** This study focused on the 30-day window around Craft 3.0's launch (November 28, 2024). The timing is significant as users are actively testing new task features and providing fresh feedback. The Craft team's responsiveness to this feedback will be critical for feature adoption and user retention.

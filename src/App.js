import './App.css';

const events = [
  {
    id: 'copa-grand-finale',
    name: 'Copa De Singapura - Grand Finale',
    date: '2026-11-14',
  },
];

function getDaysUntil(dateString) {
  const today = new Date();
  const startOfToday = new Date(
    today.getFullYear(),
    today.getMonth(),
    today.getDate()
  );
  const [year, month, day] = dateString.split('-').map(Number);
  const eventDate = new Date(year, month - 1, day);
  const millisecondsPerDay = 24 * 60 * 60 * 1000;

  return Math.ceil((eventDate - startOfToday) / millisecondsPerDay);
}

function formatDate(dateString) {
  const [year, month, day] = dateString.split('-').map(Number);

  return new Intl.DateTimeFormat('en-SG', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  }).format(new Date(year, month - 1, day));
}

function App() {
  const featuredEvent = events[0];
  const daysRemaining = getDaysUntil(featuredEvent.date);
  const isToday = daysRemaining === 0;
  const hasPassed = daysRemaining < 0;

  return (
    <main className="App">
      <section className="countdown-shell" aria-labelledby="countdown-title">
        <p className="eyebrow">Countdown Tracker</p>
        <h1 id="countdown-title">{featuredEvent.name}</h1>
        <p className="event-date">{formatDate(featuredEvent.date)}</p>

        <div className="countdown-panel" aria-live="polite">
          <span className="countdown-number">{Math.abs(daysRemaining)}</span>
          <span className="countdown-label">
            {isToday ? 'happening today' : hasPassed ? 'days since' : 'days to go'}
          </span>
        </div>
      </section>
    </main>
  );
}

export default App;

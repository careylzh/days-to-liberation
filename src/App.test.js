import { render, screen } from '@testing-library/react';
import App from './App';

test('renders the sample countdown event', () => {
  render(<App />);
  expect(
    screen.getByRole('heading', {
      name: /copa de singapura - grand finale/i,
    })
  ).toBeInTheDocument();
  expect(screen.getByText(/14 november 2026/i)).toBeInTheDocument();
});

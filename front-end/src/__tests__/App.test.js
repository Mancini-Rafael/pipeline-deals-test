import React from 'react';
import { render, unmountComponentAtNode } from "react-dom";
import { act } from 'react-dom/test-utils';
import App from '../App';

let container = null;
beforeEach(() => {
  container = document.createElement("div");
  document.body.appendChild(container);
});
afterEach(() => {
  unmountComponentAtNode(container);
  container.remove();
  container = null;
});

test('renders both buttons (sort deals and update deals)', () => {
  act(() => {
    render(<App />, container);
  });
  expect(container.textContent).toMatch(/Update Deals/i);
  expect(container.textContent).toMatch(/Sort By Percentage/i);
});

test('It renders the list items based on the API response', async () => {
  const dealsData = [
      { id: 1,
        name: 'This is the best deal ever',
        percent: 100},
      { id: 2,
        name: 'This deal is not so great',
        percent: 60 }
  ]
  jest.spyOn(global, "fetch").mockImplementation(() =>
    Promise.resolve({
      json: () => Promise.resolve(dealsData)
    })
  );
  await act( async () => {
    render(<App />, container);
  })
  expect(container.textContent).toMatch(/This is the best deal ever/i);
  expect(container.textContent).toMatch(/100/i);
  expect(container.textContent).toMatch(/This deal is not so great/i);
  expect(container.textContent).toMatch(/60/i);
  global.fetch.mockRestore();
});

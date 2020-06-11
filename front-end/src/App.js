import React, { useState, useEffect } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Button, Row, Col, ListGroup, Container } from '../node_modules/react-bootstrap';

function App() {
  const [deals, setDeals] = useState(null);
  useEffect(() => {
    requestDeals();
  }, [])

  const requestDeals = async () => {
    const response = await fetch(`${process.env.REACT_APP_PIPELINE_DEALS_API_ENDPOINT}`).then(
      response => response.json()
    ).catch( () => { console.log("Error fetching data from API") } )
    if (response) {
      var responseDeals = await response
      const [...deals] = responseDeals
      setDeals(deals)
    }
  }

  const handleButtonClick = () => {
    requestDeals();
  };
  const handleSortButtonClick = (deals) => {
    const sortedDeals = [...deals].sort((a, b) => b['percent'] - a['percent']); // TODO CHANGE PROPERTY
    setDeals(sortedDeals)
  }

  return (
    <Container>
      <Col>
        <Row className="mt-5">
          <Col className="text-center new-request">
            <Button variant="outline-primary" onClick={handleButtonClick} size="lg" block>
              Update Deals
            </Button>
          </Col>
          <Col className="text-center new-request">
            <Button variant="outline-primary" onClick={() => handleSortButtonClick(deals)} size="lg" block>
              Sort By Percentage
            </Button>
          </Col>
        </Row>
        <Row className="mt-5 mb-5">
          <Col className="text-center list-deals">
            <ListGroup>
            <ListGroup.Item>
              <Row>
                <Col>
                  NAME
                </Col>
                <Col>
                  PERCENTAGE
                </Col>
              </Row>
            </ListGroup.Item>
              {
                deals && deals.map( (deal) => {
                  return (
                    <ListGroup.Item key={deal.id}> 
                      <Row>
                        <Col>
                          {deal.name}
                        </Col>
                        <Col>
                          {deal.percent}
                        </Col>
                      </Row>
                    </ListGroup.Item>
                  )
                })
              }
            </ListGroup>
          </Col>
        </Row>
      </Col>
    </Container>
  );
}

export default App;

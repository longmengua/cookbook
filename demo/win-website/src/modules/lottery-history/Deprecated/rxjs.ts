import {timer, from, of, Observable, fromEvent, interval, Subscriber, empty, Subject, observable} from "rxjs";
import {concatMap, map, switchMap, catchError, tap, concatAll, takeUntil, switchAll, take, mergeAll, mapTo, filter} from "rxjs/operators";
import {ajax} from "rxjs/ajax";
import {fromFetch} from "rxjs/fetch";
import {SearchWinningNumberAJAXRequest} from "type/api";
import {GameWinningNumberAJAXWebService} from "services/GameWinningNumberAJAXWebService";

const click = fromEvent(document.body, "click");
const source = click.pipe(
    map(() =>
        interval(1000)
            .pipe
            // take(3),
            ()
    ),
    mergeAll()
);

source.subscribe({
    next: value => {
        console.info(value);
    },
    error: err => {
        console.info("Error: " + err);
    },
    complete: () => {
        console.info("complete");
    },
});

const fetchInterval$ = new Observable((subscriber: Subscriber<string>) => {
    subscriber.next("Fetch");
    setInterval(() => {
        subscriber.next("Fetch");
    }, 2000);
});

const subject = new Subject();

const FetchDataPromise2 = new Promise<{hello: string; name: string}>((resolve, reject) => {
    ajax({
        url: "http://www.mocky.io/v2/5d37c84b310000119fb079db",
    })
        .pipe(
            tap(response => console.info("response: ", response)),
            catchError(error => {
                console.info("error: ", error);
                return of(error);
            })
        )
        .subscribe({
            next: response => {
                console.info("response", response.response);
                resolve(response.response);
            },
            // complete: ()
            error: err => {
                reject(err);
            },
        });
});

function getFetch$(gameCode: string, pageSize: number = 10, pageNumber: number = 10) {
    const fetch$ = fromFetch(`/ajax/game-winning-number?gameCode=${gameCode}&pageSize=${pageSize}&pageNumber=${pageNumber}`).pipe(
        switchMap(response => {
            if (response.ok) {
                return response.json();
            } else {
                console.info("response", response);
                return of({error: true, message: `${response.status} ${response.statusText}`});
            }
        }),
        catchError(err => {
            console.error("catchError", err);
            return of({error: true, message: err.message});
        })
    );
    return fetch$;
}

timer(0, 2000)
    .pipe(
        mapTo(
            from(FetchDataPromise2).pipe(
                filter(response => response.name === "andy")
                // pluck("name"),
            )
        ),
        concatAll(),
        takeUntil(subject.asObservable())
    )
    .subscribe({
        next: element => {
            console.info("next", element);
        },
        complete: () => {
            console.info("complete");
        },
        error: err => {
            console.info("error", err);
        },
    });

const FetchData$ = (request: SearchWinningNumberAJAXRequest) => {
    return from(GameWinningNumberAJAXWebService.searchWinningNumber(request));
};

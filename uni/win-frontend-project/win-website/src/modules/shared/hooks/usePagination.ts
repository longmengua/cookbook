import React, {useState, useEffect, useDebugValue} from "react";

interface Pagination {
    // Item
    itemTotalSize: number;
    // Page
    pageCount: number;
    currentPageNumber: number;
    // NOTICE: React.Dispatch<React.SetStateAction<number>>
    setCurrentPageNumber: React.Dispatch<React.SetStateAction<number>>;
    // Data Helper
    startItemNumber: number;
    endItemNumber: number;
}
const usePagination = (itemTotalSize: number, itemSizePerPage: number): Pagination => {
    const [currentPageNumber, setCurrentPageNumber] = useState(1);
    if (itemTotalSize === 0) {
        return {
            pageCount: 0,
            currentPageNumber: 0,
            setCurrentPageNumber,
            itemTotalSize: 0,
            startItemNumber: 0,
            endItemNumber: 0,
        };
    }
    const pageCount: number = Math.ceil(itemTotalSize / itemSizePerPage);
    const startItemNumber: number = (currentPageNumber - 1) * itemSizePerPage;
    const endItemNumber: number = startItemNumber + itemSizePerPage;
    return {
        pageCount,
        currentPageNumber,
        setCurrentPageNumber,
        itemTotalSize,
        startItemNumber,
        endItemNumber,
    };
};

export default usePagination;
